IF NOT EXISTS (SELECT * FROM sys.databases where [name] = 'PoopScoop')
BEGIN
	CREATE DATABASE PoopScoop
END
ELSE
PRINT 'PoopScoop database already exists'

IF NOT EXISTS (SELECT * FROM sys.tables WHERE [name] = 'User')
	BEGIN
		CREATE TABLE [User] 
		(
			[Id] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
			[ImageUrl] NVARCHAR(250) not null,
			[Name] NVARCHAR(250) not null,
			[City] VARCHAR(100) not null,
			[State] VARCHAR(2) not null,
			[DateCreated] DATETIME not null,
		)
	END
ELSE
	PRINT 'User table already exists'

IF NOT EXISTS (SELECT * FROM sys.tables WHERE [name] = 'Business')
	BEGIN
		CREATE TABLE [Business] 
		(
			[Id] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
			[YelpId] NVARCHAR(250) not null,
			[Zip] NVARCHAR(15) not null
		)
	END
ELSE
	PRINT 'Business table already exists'

IF NOT EXISTS (SELECT * FROM sys.tables WHERE [name] = 'AmenityType')
	BEGIN
		CREATE TABLE [AmenityType] 
		( 
			[Id] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
			[Type] VARCHAR(250) not null
		)
	END
ELSE
	PRINT 'AmenityType table already exists'

IF NOT EXISTS (SELECT * FROM sys.tables WHERE [name] = 'Amenity')
	BEGIN
		CREATE TABLE [Amenity] 
		(
			[Id] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
			[BusinessId] UNIQUEIDENTIFIER not null,
			[TypeId] UNIQUEIDENTIFIER not null,
			[Status]  BIT not null,
			[RestroomType] UNIQUEIDENTIFIER not null
		)
	END
ELSE
	PRINT 'Amenity table already exists'

	IF NOT EXISTS (SELECT * FROM sys.tables WHERE [name] = 'Avatar')
	BEGIN
		CREATE TABLE [Avatar] 
		(
			[Id] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
			[AvatarName] VARCHAR(50) not null,
			[AvatarUrl] NVARCHAR(max) not null
		)
	END
ELSE
	PRINT 'Avatar table already exists'

IF NOT EXISTS (SELECT * FROM sys.tables WHERE [name] = 'BusinessRating')
	BEGIN
		CREATE TABLE [BusinessRating] 
		(
			[Id] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
			[BusinessId] UNIQUEIDENTIFIER not null,
			[Cleanliness] SMALLINT not null,
			[Decor] SMALLINT not null,
			[RestroomType] UNIQUEIDENTIFIER not null,
			[Review] NVARCHAR(max) null,
			[TimeStamp] DATETIME not null,
			[Uid] UNIQUEIDENTIFIER not null
		)
	END
ELSE
	PRINT 'BusinessRating table already exists'

IF NOT EXISTS (SELECT * FROM sys.tables WHERE [name] = 'RestroomType')
	BEGIN
		CREATE TABLE [RestroomType] 
		(
			[Id] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
			[hex] NVARCHAR(10) not null,
			[RestroomType] VARCHAR(6) not null,
		)
	END
ELSE
	PRINT 'RestroomType table already exists'

IF NOT EXISTS (SELECT * FROM sys.tables WHERE [name] = 'States')
	BEGIN
		CREATE TABLE [States] 
		(
			[Id] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
			[StateAbbreviation] VARCHAR(2) not null,
			[StateName] VARCHAR(20) not null
		)
	END
ELSE
	PRINT 'States table already exists'


IF NOT EXISTS (SELECT * FROM sys.tables WHERE [name] = 'Cities')
	BEGIN
		CREATE TABLE [Cities] 
		(
			[Id] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
			[StateId] UNIQUEIDENTIFIER not null,
			[CityName] VARCHAR(50) not null
		)
	END
ELSE
	PRINT 'Cities table already exists'


IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE [name] = 'FK_Amenity_Business')
	BEGIN
		ALTER TABLE Amenity
		ADD constraint FK_Amenity_Business 
			foreign key (BusinessId) 
			references Business (Id)
	END
ELSE
	PRINT 'FK_Amenity_Business already exists'

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE [name] = 'FK_Amenity_AmenityType')
	BEGIN
		ALTER TABLE Amenity
		ADD constraint FK_Amenity_AmenityType
			foreign key (TypeId) 
			references AmenityType (Id)
	END
ELSE
	PRINT 'FK_Amenity_AmenityType already exists'

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE [name] = 'FK_Amenity_RestroomType')
	BEGIN
		ALTER TABLE Amenity
		ADD constraint FK_Amenity_RestroomType
			foreign key (RestroomType) 
			references RestroomType (Id)
	END
ELSE
	PRINT 'FK_Amenity_RestroomType already exists'

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE [name] = 'FK_BusinessRating_User')
	BEGIN
		ALTER TABLE BusinessRating
		ADD constraint FK_BusinessRating_User
			foreign key ([Uid])
			references [User] (Id)
	END
ELSE
	PRINT 'FK_BusinessRating_User already exists'

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE [name] = 'FK_BusinessRating_Business')
	BEGIN
		ALTER TABLE BusinessRating
		ADD constraint FK_BusinessRating_Business
			foreign key (BusinessId)
			references Business (Id)
	END
ELSE
	PRINT 'FK_BusinessRating_Business already exists'


IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE [name] = 'FK_BusinessRating_RestroomType')
	BEGIN
		ALTER TABLE BusinessRating
		ADD constraint FK_BusinessRating_RestroomType
			foreign key (RestroomType)
			references RestroomType (Id)
	END
ELSE
	PRINT 'FK_BusinessRating_RestroomType already exists'

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE [name] = 'FK_Cities_States')
	BEGIN
		ALTER TABLE Cities
		ADD constraint FK_Cities_States
			foreign key (StateId)
			references States (Id)
	END
ELSE
	PRINT 'FK_Cities_States already exists'