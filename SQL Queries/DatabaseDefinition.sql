CREATE DATABASE Portfolio;
USE Portfolio;

-- ###########################################################################

CREATE TABLE User (
	UserID INT PRIMARY KEY AUTO_INCREMENT,
	Username VARCHAR(20) UNIQUE NOT NULL,
	FirstName VARCHAR(20) NOT NULL,
	LastName VARCHAR(20)
);

CREATE TABLE Shares (
	Symbol VARCHAR(10) PRIMARY KEY,
	ShareName VARCHAR(30) UNIQUE NOT NULL,
	Information VARCHAR(200),
	CurrentPrice FLOAT(7, 2) NOT NULL CHECK (CurrentPrice > 0)
);

CREATE TABLE Currency (
	Abbreviation VARCHAR(10) PRIMARY KEY,
	CurrencyName VARCHAR(20) NOT NULL,
	PriceInUSD FLOAT(7, 2) NOT NULL CHECK (PriceInUSD > 0)
);

-- ###########################################################################

CREATE TABLE ShareHistory (
	TimeLog TIMESTAMP,
	ShareSymbol VARCHAR(10) REFERENCES Shares(Symbol) ON DELETE CASCADE ON UPDATE CASCADE,
	Price FLOAT(7, 2) NOT NULL CHECK (CurrentPrice > 0),
	CONSTRAINT primeKey PRIMARY KEY (ShareSymbol, TimeLog)
);

CREATE TABLE WatchList (
	UserID INT REFERENCES User(UserID) ON DELETE CASCADE ON UPDATE CASCADE,
	ShareSymbol VARCHAR(10) REFERENCES Shares(Symbol) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT primeKey PRIMARY KEY (UserID, ShareSymbol)
);

CREATE TABLE BuyShare (
	TimeLog TIMESTAMP,
	UserID INT REFERENCES User(UserID) ON DELETE CASCADE ON UPDATE CASCADE,
	Quantity INT CHECK (Quantity > 0),
	ShareSymbol VARCHAR(10) REFERENCES Shares(Symbol) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT primeKey PRIMARY KEY (UserID, TimeLog)
);

CREATE TABLE SellShare (
	TimeLog TIMESTAMP,
	UserID INT REFERENCES User(UserID) ON DELETE CASCADE ON UPDATE CASCADE,
	Quantity INT CHECK (Quantity > 0),
	ShareSymbol VARCHAR(10) REFERENCES Shares(Symbol) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT primeKey PRIMARY KEY (UserID, TimeLog)
);

CREATE TABLE CurrentShares (
	UserID INT REFERENCES User(UserID) ON DELETE CASCADE ON UPDATE CASCADE,
	Quantity INT CHECK (Quantity > 0),
	Invested FLOAT(7, 2) NOT NULL CHECK (Invested > 0),
	ShareSymbol VARCHAR(10) REFERENCES Shares(Symbol) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT primeKey PRIMARY KEY (UserID, ShareSymbol)
);

CREATE TABLE UserHistory (
	UserID INT REFERENCES User(UserID) ON DELETE CASCADE ON UPDATE CASCADE,
	Quantity INT CHECK (Quantity > 0),
	TimeLog TIMESTAMP,
	Price FLOAT(7, 2) NOT NULL CHECK (Invested > 0),
	BuySellFlag INT CHECK (BuySellFlag = 0 OR BuySellFlag = 1),
	ShareSymbol VARCHAR(10) REFERENCES Shares(Symbol) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT primeKey PRIMARY KEY (UserID, TimeLog)
);

CREATE TABLE CurrencyHistory (
	Abbreviation VARCHAR(10) REFERENCES Currency(Abbreviation) ON DELETE CASCADE ON UPDATE CASCADE,
	TimeLog TIMESTAMP,
	PriceInUSD FLOAT(7, 2) NOT NULL CHECK (PriceInUSD > 0),
	CONSTRAINT primeKey PRIMARY KEY (Abbreviation, TimeLog)
);

CREATE TABLE CurrencyExchange (
	TimeLog TIMESTAMP,
	UserID INT REFERENCES User(UserID) ON DELETE CASCADE ON UPDATE CASCADE,
	FromCurrency VARCHAR(10) REFERENCES Currency(Abbreviation) ON DELETE CASCADE ON UPDATE CASCADE,
	ToCurrency VARCHAR(10) REFERENCES Currency(Abbreviation) ON DELETE CASCADE ON UPDATE CASCADE,
	FromAmount FLOAT(7, 2) NOT NULL CHECK (FromAmount > 0),
	CONSTRAINT primeKey PRIMARY KEY (UserID, TimeLog)
);

CREATE TABLE UserCurrencies (
	UserID INT REFERENCES User(UserID) ON DELETE CASCADE ON UPDATE CASCADE,
	CurrencyName VARCHAR(10) REFERENCES Currency(Abbreviation) ON DELETE CASCADE ON UPDATE CASCADE,
	Amount FLOAT(7, 2) NOT NULL CHECK (Amount > 0)
);

-- Deleting all tables

DROP TABLE User;
DROP TABLE Shares;
DROP TABLE Currency;
DROP TABLE ShareHistory;
DROP TABLE WatchList;
DROP TABLE BuyShare;
DROP TABLE SellShare;
DROP TABLE CurrentShares;
DROP TABLE UserHistory;
DROP TABLE CurrencyHistory;
DROP TABLE CurrencyExchange;
DROP TABLE UserCurrencies;