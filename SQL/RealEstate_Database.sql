/*
Create sql database with sql
Create docker container that creates sql database and lets user query through database
*/

/*---------------------------------------------------------------------*/	 
/*				 	    Set context to master	  					   */
/*---------------------------------------------------------------------*/
USE MASTER; 

/*---------------------------------------------------------------------*/	 
/* If the RealEstate database exists, DROP it so database can run	   */
/*---------------------------------------------------------------------*/

IF EXISTS (SELECT * FROM Master.dbo.sysdatabases WHERE NAME = 'RealEstate')
DROP DATABASE RealEstate;
GO

/*------------------------------------------------------------*/
/*             Create the REAL ESTATE Database                */
/*------------------------------------------------------------*/

CREATE DATABASE RealEstate;
GO 

USE RealEstate;

/*------------------------------------------------------------*/
/*              Create the PEOPLE table						  */
/*------------------------------------------------------------*/
-- schema: PEOPLE (PersonID, FirstName, LastName, PhoneNumber)

CREATE TABLE tblPeople 
(
	PersonID	int             PRIMARY KEY,
	FirstName	varchar(64)     NOT NULL   ,
	LastName	varchar(64)	    NOT NULL   ,
	PhoneNumber varchar(64)	
);

-- Insert data into the PEOPLE table
INSERT INTO tblPeople VALUES   
(1001, 'Phil'   , 'Collins' , '6195559900'),
(1002, 'Ted'    , 'Mosley'  , '2125554000'),
(1003, 'Elvis'  , 'Costello', '4205550000'),
(1004, 'Ryan'   , 'Gosling' , '8225555678'),
(1005, 'Juan'   , 'Hornito' , '5605555031'),
(1006, 'John'   , 'Legend'  , '2845555000'),
(1007, 'Bill'   , 'Ernie'   , '3455559123'),
(1008, 'Beyonce', 'Johnson' , '3345559031'),
(1009, 'Robert' , 'Briggs'  , '8585555401'),
(1010, 'Will'   , 'McGrath' , '6195559221'),
(1011, 'Jue'    , 'Lie'     , '6195554200'),
(1012, 'Rahul'  , 'Ambati'  , '4205550210'),
(1013, 'Emily'  , 'Lam'     , '7655555978'),
(1014, 'Melissa', 'Yakuta'  , '7605555030'),
(1015, 'Erik'   , 'Walters' , '6195559810'),
(1016, 'Bill'   , 'John'    , '3455559003'),
(1017, 'Freddie', 'Spy'     , '4325555001'),
(1018, 'Alfred' , 'Hitch'   , '8585558001'),
(1019, 'Tyrone' , 'Ali'     , '6195552222'),
(1020, 'Gabe'   , 'Ribali'  , '8585550032');

/*------------------------------------------------------------*/
/*             Create the COMPANIES table	          		  */
/*------------------------------------------------------------*/
-- schema: COMPANIES (CompanyID, CompanyName, Street, City, TheState, Zipcode)
-- 		   UNIQUE NOT NULL (Street)

CREATE TABLE tblCompanies	
(
	CompanyID		int				 PRIMARY KEY    ,	
	CompanyName		varchar(128)				    ,	
	Street   		varchar(128)	 UNIQUE	NOT NULL,
	City			varchar(128)				    ,
	TheState	    varchar(128)				    ,
	Zipcode		    varchar(128)				    ,
);

-- Insert data into the COMPANIES table
INSERT INTO tblCompanies VALUES
(10001, 'Best Real Estate'   , '15746 Star Ave'  , 'Fremont'  , 'CA', '85748'),
(10002, 'Best Homes'         , '75847 Home St'   , 'Burbank'  , 'CA', '84547'), 
(10003, 'Corn Housing'       , '64520 Mask Blvd' , 'Houston'  , 'TX', '18446'),
(10004, 'Housing for Free'   , '45712 Great Ave' , 'Miami'    ,	'FL', '75487'),
(10005, 'Forever Homes'      , '74126 Up St'     , 'Seattle'  , 'WA', '74581'),
(10006, 'No More Paying Rent', '65849 Roof Blvd' , 'Portland' , 'OR', '84751'),
(10007, 'San Diego Homes'    , '5500 Camp St'    , 'San Diego',	'CA', '95219'),
(10008, 'Roof Over'          , '54154 Oregon Ave', 'Phoenix'  ,	'AZ', '95421'),
(10009, 'Agency For You'     , '24812 Bat St'    , 'Sedona'   , 'AZ', '94572'),
(10010, 'Balloon Homes'      , '22750 Part Blvd' , 'Las Vegas', 'NV', '78421');

/*------------------------------------------------------------*/
/*            Create the REAL ESTATE AGENTS table	          */
/*------------------------------------------------------------*/
-- schema: REAL_ESTATE_AGENTS (AgentID, AK(RSLicenseNo), Region, CompanyID)
-- 		   FK AgentID references PEOPLE 
-- 		   FK CompanyID references COMPANIES 
-- 		   UNIQUE NOT NULL (RSLicenseNo)

CREATE TABLE tblRealEstateAgents
(
	AgentID 	int              PRIMARY KEY        REFERENCES tblPeople   , -- Setup a column and designate it as primary key
	RSLicenseNo	varchar(64)      UNIQUE NOT NULL                           , -- Alternative Key
	Region 	    varchar(128)	                                           , 
	CompanyID   int	                                REFERENCES tblCompanies		
);

-- Insert data into the REAL ESTATE AGENTS table
INSERT INTO tblRealEstateAgents VALUES  
(1001, '#20004559', 'Northeast'   , 10001),  
(1002, '#30908579', 'Southwest'   , 10001),    
(1003, '#44004559', 'Central'     , 10003),   
(1004, '#70024355', 'Southeast'   , 10007),  
(1005, '#90112456', 'Northwest'   , 10007),    
(1006, '#10002233', 'Northeast'   , 10004),    
(1007, '#20003455', 'Mid-Atlantic', 10010),   
(1008, '#34556459', 'Northwest'   , 10009), 
(1009, '#80007411', 'Central'     , 10005),
(1010, '#98217411', 'Central'     , 10008);  

/*------------------------------------------------------------*/
/*          Create the BUYING SELLING STAGES table	     	  */
/*------------------------------------------------------------*/
-- schema: BUYING_SELLING_STAGES (StageID, Stage) 

CREATE TABLE tblBuyingSellingStages
(   
	StageID		  int		        PRIMARY KEY,
	Stage         varchar(64)
);

-- Insert data into the BUYING SELLING STAGES table
INSERT INTO tblBuyingSellingStages VALUES
(100001, 'Started'   ),
(100002, 'Processing'),
(100003, 'Approved'  ),
(100004, 'Closed'    ),
(100005, 'Denied'    );

/*------------------------------------------------------------*/
/*               Create the LISTINGS table	     	 		  */
/*------------------------------------------------------------*/
-- schema: LISTINGS (ListingID, AgentID, Street, City, TheState, Zip Code, NoBedrooms, NoBaths, SquareFt, PropetyTax, HOAFee, 
--                   EstClosingCost, AppraisalAmount)
-- 		   FK AgentID references REAL_ESTATE_AGENTS
-- 		   UNIQUE NOT NULL (Street)

CREATE TABLE tblListings
(	
	ListingID		   int  			 PRIMARY KEY							   ,
	AgentID            int               FOREIGN KEY REFERENCES tblRealEstateAgents,
	Street             varchar(64)		 UNIQUE	NOT NULL						   ,
	City               varchar(64)                                                 ,
	TheState           varchar(64)                                                 ,
	ZipCode            varchar(64)                                                 ,  
	NoBedrooms		   varchar(64)											       ,
	NoBaths			   varchar(64)												   ,
	SquareFt           int														   ,
	PropetyTax		   int														   ,
	HOAFee			   int														   ,
	EstClosingCost     int														   ,
	AppraisalAmount    int
);

-- Insert data into the LISTINGS table
INSERT INTO tblListings VALUES
(1111, 1001, '1111 Banana Ave' , 'Chula Vista', 'CA', '91913', '4', '2', 1200, 7000 , 1000, 18000, 5000),
(1112, 1002, '2222 Apple Rd'   , 'San Diego'  , 'CA', '92212', '5', '3', 2000, 7500 , 1500, 20500, 4000),
(1113, 1003, '2232 Cat Ave'    , 'Chula Vista', 'CA', '91913', '2', '1', 1000, 2000 , 950 , 16000, 3000),
(1114, 1004, '2332 Peach Ave'  , 'San Diego'  , 'CA', '91112', '6', '3', 4000, 10000, 700 , 30000, 2000),
(1115, 1005, '3000 Pet Ct'     , 'La Jolla'   , 'CA', '92037', '4', '1', 1000, 6000 , 990 , 16500, 1200),
(1116, 1006, '4200 Pile Ave'   , 'Oceanside'  , 'CA', '92003', '6', '2', 3000, 9500 , 1000, 29000, 1500),
(1117, 1007, '3333 Holiday Dr' , 'Bonita'     , 'CA', '91902', '2', '2', 1200, 4900 , 1100, 18500, 2000),
(1118, 1008, '1641 Orange Ave' , 'Bonita'     , 'CA', '91902', '2', '2', 1100, 5000 , 1000, 19500, 1500),
(1119, 1009, '231 Harvard Ave' , 'Bonita'     , 'CA', '91902', '2', '2', 1200, 4900 , 1100, 18500, 1000),
(1120, 1010, '3421 Anderson Dr', 'La Jolla'   , 'CA', '92037', '2', '3', 1200, 7000 , 1100, 20000, 2000);

/*------------------------------------------------------------*/
/*               Create the CLIENTS table	          		  */
/*------------------------------------------------------------*/
-- schema: CLIENTS (ClientID, DOB, Street, City, TheState, ZipCode, Region, Gender, SSN, Income, PrimaryEmployer, JobTitle, 
--				    BuyingIndicator, PriceRange, CurrentHouseholdSize, TypeOfHome, PoolInd, HOAInd, StageID)
-- 		   FK ClientID references PEOPLE 
--         FK StageID references BUYING_SELLING_STAGES
--         UNIQUE (SSN)
--         UNIQUE NOT NULL (Street)

CREATE TABLE tblClients
(
	ClientID	           int			   PRIMARY KEY REFERENCES tblPeople ,
	DOB                    date                                             ,
	Street       		   varchar(64)	   UNIQUE NOT NULL			        ,
	City                   varchar(64)                                      ,
	TheState               varchar(64)                                      ,
	ZipCode                varchar(64)                                      ,  
	Region          	   varchar(64)                                      ,
	Gender                 varchar(64)                                      ,
	SSN                    varchar(64)     UNIQUE                           ,
	Income                 int                                              ,
	PrimaryEmployer        varchar(64)                                      ,
	JobTitle               varchar(64)                                      ,
	BuyingIndicator        varchar(64)                                      ,
	PriceRange             varchar(64)                                      ,
	CurrentHouseholdSize   int                                              ,
	TypeofHome             varchar(64)                                      ,
	PoolInd                varchar(64)                                      ,
	HOAInd	               varchar(64)                                      ,
	StageID                int             REFERENCES tblBuyingSellingStages 
);

-- Insert data into the CLIENTS table
INSERT INTO tblClients VALUES
(1011, '1990-01-10'            , '123 Olive St'        , 'San Diego'  , 'CA'             , '92101', 'San Diego'     , 'F', '000-12-0000', 50000  , 
	   'County of SD'          , 'Social Worker'       , 'Buy'        , '500,000-650,000', 2      , 'Townhome'      , 1  , 0            , 100001),
(1012, '1982-07-28'            , '733 Grand Ave'       , 'Chula Vista', 'CA'             , '91910', 'San Diego'     , 'F', '000-13-0000', 120000 , 
	   'Amazon'                , 'Data Analyst'        , 'Buy'        , '700,000-800,000', 3      , 'Full Size Home', 1  , 1            , 100001),
(1013, '1967-07-04'            , '3940 Emerald Ln #304', 'Yuma'       , 'AZ'			 , '85364', 'San Diego'     , 'M', '000-14-0000', 60000  , 
	   'Yuma Medical Center'   , 'Patient Rep'         , 'Buy'	      , '2,000-2,500'	 , 2      , 'Apartment'     , 0  , 0			, 100002),
(1014, '1995-02-13'            , '134 Manhattan Ave'   , 'New York'   , 'NY'             , '10001', 'New York'      , 'F', '000-15-0000', 70000  , 
	   'Northwell Health'      , 'Registered Nurse'    , 'Buy'        , '2,000-2,500'    , 1      , 'Apartment'	 	, 0  , 0            , 100003),
(1015, '1977-08-28'            , '589 Harmony Grove'   , 'Portland'   , 'OR'             , '97219', 'Portland'      , 'F', '000-16-0000', 50000  , 
	   'Portland State College', 'Research Assistant'  , 'Buy'        , '1,800-2,000'    , 1      , 'Apartment'		, 1  , 0            , 100004),
(1016, '1970-04-20'            , '1546 Homan Ave'      , 'Chicago'    , 'IL'             , '60623', 'Chicago'       , 'F', '000-17-0000', 150000 , 
	   'Chicago Family Health' , 'Physician Assistant' , 'Buy'        , '750,000-850,000', 4      , 'Full Size Home', 1  , 0            , 100001),
(1017, '1980-10-25'            , '435 Hummingbird Ln'  , 'Carlsbad'   , 'CA'             , '92009', 'San Diego'     , 'M', '000-18-0000', 90000  , 
	   'ViaSat'			       , 'UX Designer'         , 'Buy'        , '600,000-700,000', 5      , 'Full Size Home', 1  , 1            , 100005),
(1018, '1978-03-05'            , '5031 Richardson Dr'  , 'Portland'   , 'OR'             , '97239', 'Portland'      , 'M', '000-19-0000', 180000 , 
	   'Microsoft'             , 'Hardware Engineer'   , 'Buy'        , '800,000-950,000', 3      , 'Full Size Home', 1  , 1            , 100003),
(1019, '1994-12-15'            , '1234 Olive Dr'       , 'Los Angeles', 'CA'             , '90001', 'Los Angeles'   , 'M', '000-20-0000', 180000 , 
	   'Facebook'              , 'Software Engineer'   , 'Buy'        , '800,000-950,000', 2      , 'Full Size Home', 1  , 1            , 100003),
(1020, '1985-11-20'            , '5774 Llamas Dr'      , 'Mira Mesa'  , 'CA'             , '92126', 'San Diego'     , 'F', '000-21-0000', 120000 , 
	   'Qualcomm'              , 'Data Scientist'      , 'Buy'        , '700,000-900,000', 3      , 'Full Size Home', 1  , 1            , 100003);

/*------------------------------------------------------------*/
/*            Create the BUYING OR SELLING table	          */
/*------------------------------------------------------------*/
-- schema: BUYING_OR_SELLING (AgentID, ClientID, BuyingOrSellingInd)
-- 	       FK AgentID references REAL_ESTATE_AGENTS
--         FK ClientID references CLIENTS 

CREATE TABLE tblBuyingOrSelling
(
	AgentID 				int 			 PRIMARY KEY REFERENCES tblRealEstateAgents,
	ClientID 				int 			 REFERENCES tblClients					   ,
	BuyingOrSellingInd  	varchar(64)
); 

-- Insert data into the BUYING OR SELLING table
INSERT INTO tblBuyingOrSelling VALUES
(1001, 1011, 1),
(1002, 1012, 1),
(1003, 1013, 0),
(1004, 1014, 0),
(1005, 1015, 1),
(1006, 1016, 1),
(1007, 1017, 0),
(1008, 1018, 1),
(1009, 1019, 1),
(1010, 1020, 1); 

/*------------------------------------------------------------*/
/*     	  	Create the LOCATIONS OF INTEREST table	          */
/*------------------------------------------------------------*/
-- schema: LOCATIONS_OF_ INTEREST (LocationOfInterestID, City, ZipCode)
-- 		   NOT NULL (City, ZipCode)

CREATE TABLE tblLocationsOfInterest
(
	LocationOfInterestID		int				PRIMARY KEY,	
	City						varchar(64)	    NOT NULL   ,	
	Zipcode					    varchar(64)	    NOT NULL
);

-- Insert data into the LOCATIONS OF INTEREST table
INSERT INTO tblLocationsOfInterest VALUES
(2001, 'Bonita'     , '91902'),
(2002, 'San Diego'  , '92101'), 
(2003, 'La Jolla'   , '92037'),		
(2004, 'Bonita'     , '91902'),		
(2005, 'Chula Vista', '91913'),
(2006, 'San Diego'  , '92101'),	
(2007, 'Las Vegas'  , '89101'), 	
(2008, 'Los Angeles', '90001'),		
(2009, 'Phoenix'    , '85001'),		
(2010, 'San Diego'  , '92101');

/*------------------------------------------------------------*/
/*     Create the LOCATIONS OF INTEREST FOR CLIENTS table	  */
/*------------------------------------------------------------*/
-- schema: LOCATIONS_OF_INTEREST_FOR_CLIENTS (ClientID, LocationOfInterestID, InterestRank)
-- 		   FK ClientID references CLIENTS
--         FK LocationOfInterestID references LOCATIONS_OF_INTEREST
--         NOT NULL (InterestRank)

CREATE TABLE tblLocationsOfInterestForClients
(
	ClientID	               int		      PRIMARY KEY REFERENCES tblClients,
	LocationOfInterestID       int            REFERENCES tblLocationsOfInterest, 
	InterestRank               varchar(64)    NOT NULL
);

-- Insert data into the LOCATIONS OF INTEREST FOR CLIENTS table
INSERT INTO tblLocationsOfInterestForClients VALUES
(1011, 2001, 'Primary Choice'  ),
(1012, 2002, 'Primary Choice'  ),
(1013, 2003, 'Primary Choice'  ),
(1014, 2004, 'Secondary Choice'),
(1015, 2005, 'Primary Choice'  ),
(1016, 2006, 'Primary Choice'  ),
(1017, 2007, 'Secondary Choice'),
(1018, 2008, 'Third Choice'    ),
(1019, 2009, 'Primary Choice'  ),
(1020, 2010, 'Secondary Choice');

/*------------------------------------------------------------*/
/*             Create the SALES CONTRACTS table	              */
/*------------------------------------------------------------*/
-- schema: SALES_CONTRACTS (SalesContractID, PaymentMethod)
--         NOT NULL (PaymentMethod)

CREATE TABLE tblSalesContracts 
(
	SalesContractID 	int               PRIMARY KEY,
	PaymentMethod	    varchar(64)       NOT NULL   ,
);

-- Insert data into the SALES CONTRACTS table
INSERT INTO tblSalesContracts VALUES   
(01001, 'Bank Transfer'),  
(01002, 'Check'        ),    
(01003, 'Wire Transfer'),   
(01004, 'Cash'         ),    
(01005, 'Credit Card'  );

/*------------------------------------------------------------*/
/*              Create the OFFERS table	          			  */
/*------------------------------------------------------------*/
-- schema: OFFERS (ClientID, ListingID, OfferAmount, OfferStatus, SalesContractID)
-- foreign key ClientID references CLIENTS
-- foreign key ListingID references LISTINGS
-- foreign key SalesContractID references SALES_CONTRACTS
-- NOT NULL (OfferStatus)

CREATE TABLE tblOffers 
(
	ClientID      		int   			PRIMARY KEY REFERENCES  	   tblClients, 
	ListingID     		int   			REFERENCES               	  tblListings, 
	OfferAmount   		varchar(64)        							     		 , 
	OfferStatus   		varchar(64)		NOT NULL								 ,
	SalesContractID		int  			REFERENCES 				tblSalesContracts
);

-- Insert data into the OFFERS table 	
INSERT INTO tblOffers VALUES
(1011, 1111, '300000', 'In Progress', 01001),
(1012, 1112, '350000', 'In Progress', 01001),
(1013, 1113, '600000', 'Closed'     , 01002),
(1014, 1114, '430000', 'In Progress', 01003),
(1015, 1115, '250000', 'Closed'     , 01004),
(1016, 1116, '700000', 'Submitted'  , 01005),
(1017, 1117, '900000', 'Submitted'  , 01003),
(1018, 1118, '670000', 'Submitted'  , 01003),
(1019, 1119, '830000', 'In Progress', 01002),
(1020, 1120, '320000', 'Accepted'   , 01001);

/*------------------------------------------------------------*/
/*             	  Create the LENDERS table	              	  */
/*------------------------------------------------------------*/
-- schema: LENDERS (LenderID, LenderFirstName, LenderLastName, BankName, Street, City, TheState, ZipCode, BankType) 
-- 		   UNIQUE NOT NULL (Street)
--         NOT NULL (BankName, BankType)

CREATE TABLE tblLenders
(
	LenderID 	   		 int              PRIMARY KEY    ,
	LenderFirstName		 varchar(64) 				     ,
	LenderLastName		 varchar(64) 				     ,
	BankName	         varchar(64)      NOT NULL       ,
	Street       		 varchar(64)	  UNIQUE NOT NULL,
	City                 varchar(64)                     ,
	TheState             varchar(64)                     ,
	ZipCode              varchar(64)                     ,
	BankType			 varchar(64)	  NOT NULL       ,
);

-- Insert data into the LENDERS table
INSERT INTO tblLenders VALUES
(1101, 'Bill'   , 'Myers'    , 'Bank Of America'    , '111 Fig Ave'       , 'San Diego'  , 'CA', '91913', 'Retail'      ),
(1102, 'John'   , 'Newman'   , 'Old Bank'           , '100 Old Rd'        , 'San Diego'  , 'CA', '91910', 'Retail'      ),
(1103, 'Sarah'  , 'Johnson'  , 'Chase'              , '320 New Rd'        , 'Los Angeles', 'CA', '90001', 'Credit Union'),
(1104, 'Liana'  , 'McMann'   , 'New Bank'           , '823 Banana Ave'    , 'San Diego'  , 'CA', '91913', 'Retail'      ),
(1105, 'Michael', 'Jordan'   , 'Wells Fargo'        , '145 Adams Ave'     , 'San Diego'  , 'CA', '91913', 'Retail'      ),
(1106, 'Chris'  , 'Murphy'   , 'US Bank'            , '1654 Ranch Dr'     , 'San Diego'  , 'CA', '91913', 'Credit Union'),
(1107, 'Adam'   , 'Gilchrist', 'Silicon Valley Bank', '971 Ryan Dr'       , 'San Diego'  , 'CA', '91913', 'Credit Union'),
(1108, 'Ian'    , 'Healy'    , 'Chase'              , '747 Calaveras Blvd', 'San Diego'  , 'CA', '91915', 'Credit Union'),
(1109, 'Kayla'  , 'Wright'   , 'Bank of America'    , '111 Apple Ave'     , 'San Diego'  , 'CA', '91913', 'Retail'      ),
(1110, 'Joana'  , 'Quiles'   , 'Chase'              , '320 Classic Rd'    , 'Los Angeles', 'CA', '90001', 'Credit Union');

/*------------------------------------------------------------*/
/*              Create the LOANS table	          			  */
/*------------------------------------------------------------*/
-- schema: LOANS (LoanID, InterestRate, TypeOfLoan, Amount, ExpirationDate, MortgageType, DateOfSanction, DateofDisbursement, 
--                DownPayment, PMI, SalesContractID, LenderID)
-- 		   FK SalesContractID references SALES_CONTRACTS
--         FK LenderID references LENDERS
--         NOT NULL (TypeOfLoan, Amount, ExpirationDate, MortgageType, DateOfSanction, DateofDisbursement, DownPayment)

CREATE TABLE tblLoans 
(
	LoanID	              int			  PRIMARY KEY				  ,
	InterestRate          decimal(4,2)              				  ,
	TypeOfLoan            varchar(64)     NOT NULL   				  , -- Business Rules state must be fully documented
	Amount                int             NOT NULL   				  , -- Business Rules state must be fully documented
	ExpirationDate        date            NOT NULL   				  , -- Business Rules state must be fully documented
	MortgageType          varchar(64)     NOT NULL   				  , -- Business Rules state must be fully documented
	DateOfSanction        date            NOT NULL   				  , -- Business Rules state must be fully documented
	DateOfDisbursement    date            NOT NULL   				  , -- Business Rules state must be fully documented
	DownPayment           int             NOT NULL   				  , -- Business Rules state must be fully documented
	PMI                   int                           			  ,
	SalesContractID       int             REFERENCES tblSalesContracts,
	LenderID              int             REFERENCES tblLenders
);

-- Insert data into the LOANS table
INSERT INTO tblLoans VALUES
(50101, 08.25, 'Mortgage', 550000 , '2049-02-04', 'Fixed Rate'   , '2019-02-04', '2019-04-01', 110000, 0   , 01001, 1101),
(50102, 06.50, 'Mortgage', 300000 , '2049-03-21', 'Fixed Rate'   , '2019-03-20', '2019-05-20', 75000 , 0   , 01003, 1102),
(50103, 03.20, 'Mortgage', 1225000, '2049-06-14', 'Fixed Rate'   , '2019-06-14', '2019-07-20', 183750, 500 , 01003, 1103),
(50104, 03.50, 'Mortgage', 650000 , '2034-06-20', 'FHA'          , '2019-06-18', '2019-08-25', 110000, 0   , 01002, 1104),
(50105, 04.50, 'Mortgage', 825000 , '2034-08-15', 'Interest Only', '2019-08-15', '2019-09-15', 0     , 0   , 01005, 1105),
(50106, 04.25, 'Mortgage', 250000 , '2050-01-05', 'Fixed Rate'   , '2020-01-04', '2020-04-01', 12500 , 1000, 01003, 1106),
(50107, 04.75, 'Mortgage', 750000 , '2050-04-20', 'Fixed Rate'   , '2020-04-17', '2020-05-08', 150000, 0   , 01001, 1107),
(50108, 03.25, 'Mortgage', 945000 , '2050-07-28', 'Fixed Rate'   , '2020-07-28', '2020-08-21', 9450  , 1200, 01003, 1108),
(50109, 05.00, 'Mortgage', 600000 , '2050-10-25', 'VA'           , '2020-10-24', '2020-12-01', 30000 , 0   , 01001, 1109),
(50110, 03.00, 'Mortgage', 250000 , '2051-01-04', 'FHA'          , '2021-01-04', '2021-04-01', 62500 , 0   , 01002, 1110);

/*------------------------------------------------------------*/
/*              Create the CREDIT REPORTS table	              */
/*------------------------------------------------------------*/
-- schema: CREDIT_REPORTS (CreditReportID, CreditLine, TotalDebt, CreditScore, CurrentMortgage, ChildSupport, OtherLinesOfSupport, 
--                         CurrentBalance, ClientID, LenderID)
-- 		   FK ClientID references CLIENTS 
-- 		   FK LenderID references LENDERS

CREATE TABLE tblCreditReports 
(
	CreditReportID	       int		 		 PRIMARY KEY          ,
	CreditLine             varchar(64)                            ,
	TotalDebt              int                                    ,
	CreditScore            int                            		  ,
	CurrentMortgage        varchar(64)                            ,
	ChildSupport           varchar(64)                     		  ,
	OtherLinesOfSupport    varchar(64) 		                      ,
	CurrentBalance         int                                    ,
	ClientID               int  			 REFERENCES tblClients,
	LenderID               int  			 REFERENCES tblLenders,
);

-- Insert data into the CREDIT REPORTS table
INSERT INTO tblCreditReports VALUES
(30001, '100000', 55000, 777, '0'    , '3000', '1000', 10000, 1011, 1101),
(30002, '200000', 15000, 790, '20000', '0'   , '500' , 2000 , 1012, 1102),
(30003, '150000', 50000, 700, '0'    , '1000', '700' , 15000, 1013, 1103),
(30004, '400000', 40000, 792, '10000', '500' , '1000', 25000, 1014, 1104),
(30005, '125000', 25000, 698, '0'    , '0'   , '0'   , 7000 , 1015, 1105),
(30006, '500000', 45000, 715, '50000', '0'   , '600' , 17000, 1016, 1106),
(30007, '650000', 30000, 780, '25000', '0'   , '200' , 5500 , 1017, 1107),
(30008, '300000', 30000, 780, '30000', '0'   , '200' , 500  , 1018, 1108),
(30009, '100000', 30000, 780, '10000', '0'   , '1000', 1000 , 1019, 1109),
(30010, '85000' , 30000, 780, '0'    , '0'   , '500' , 3000 , 1020, 1110);

/*---------------------------------------------------------------------*/	 
/* 					 		Add Indexes						  		   */
/*---------------------------------------------------------------------*/
-- choose based on attribute you by filter a lot 

/*
Index Name: ndx_tblClients_Region
Indexed Column: Region
Purpose of Index: This index improves performance by allowing information to be retrieved more quickly 
when a real estate agent searches for listings and clients in their assigned region. 
*/

CREATE INDEX ndx_tblClients_Regions ON tblClients(Region);

/*
Index Name: ndx_tblListings_ZipCode
Indexed Column: ZipCode
Purpose of Index: This index improves performance by allowing the zip codes to be retrieved more quickly 
when a real estate agent wants to look up certain listing information or client interest information.
Agents are constantly searching for listings by zip code as they look for new available houses to sell. 
*/

CREATE INDEX ndx_tblListings_ZipCode ON tblListings(ZipCode);

/*
Index Name: ndx_tblLenders_BankName
Indexed Column: BankName
Purpose of Index: This index improves performance by allowing real estate agents to look up banks with 
the lowest interest rates for loans in order to recommend these banks to their clients. 
*/

CREATE INDEX ndx_tblLenders_BankName ON tblLenders(BankName);

/*---------------------------------------------------------------------*/	 
/* 					 		Add Queries						  		   */ 
/*---------------------------------------------------------------------*/
-- SELECT * FROM INFORMATION_SCHEMA.columns  (gets metadata from table for data dictionary)
-- WHERE Table_Name = 'tblClients';

SELECT FirstName, LastName, CreditScore
FROM tblCreditReports c
JOIN tblPeople p ON p.personID = c.clientID
WHERE CreditScore > 740
ORDER BY CreditScore DESC

SELECT DISTINCT l.LenderID, LenderFirstName, LenderLastName, BankName, CreditScore, 
	(SELECT AVG(CreditScore) FROM tblCreditReports) as AverageCreditScore
FROM tblLenders l
JOIN tblCreditReports c ON l.LenderID = c.LenderID
JOIN tblLoans lo ON lo.LenderID = l.LenderID
WHERE l.LenderID IN (SELECT LenderID FROM tblLoans)
ORDER BY CreditScore;

-- Business Question: Agent has expertise dealing with young families and wants to see what clients meet their target group.
-- Which clients were born after 1980 and have a Current Household Size greater than 1?

SELECT CONCAT(LastName, ', ', FirstName) AS FullName, DOB, CurrentHouseholdSize
FROM tblPeople P
JOIN tblClients C ON P.PersonID = C.ClientID
WHERE Year(DOB) > '1980' AND CurrentHouseholdSize > 1
ORDER BY FullName;

-- Business Question: Real estate agents want information on companies and individual agents that work outside of the 
-- regions they typically cover in Arizona and California. 
-- What real estate agents and companies are outside of California or Arizona?  

SELECT R.AgentID, FirstName, LastName, C.CompanyID, CompanyName, C.TheState 
FROM tblPeople P
FULL JOIN tblRealEstateAgents R ON P.PersonID = R.AgentID
FULL JOIN tblCompanies C ON R.CompanyID = C.CompanyID
WHERE C.TheState NOT LIKE 'CA' AND C.TheState NOT LIKE 'AZ'; 

-- Business Question: What is the average income of clients looking for homes in San Diego?

SELECT AVG(Income) AS AvgIncome
FROM tblClients c
JOIN tblLocationsOfInterestForClients ci ON c.ClientID = ci.ClientID
JOIN tblLocationsofInterest li ON ci.LocationofInterestID = li.LocationofInterestID
WHERE c.Region = 'San Diego';

-- Business Question: What is the client rank selections distribution for San Diego in the DB?

SELECT InterestRank, COUNT(*) AS Count
FROM tblLocationsOfInterestForClients ci
JOIN tblLocationsOfInterest li ON ci.LocationOfInterestID = li.LocationOfInterestID
WHERE City = 'San Diego'
GROUP BY InterestRank;

-- Business Question: What clients have very good credit scores over 740? Ordered by score with highest score first.
 
SELECT p.FirstName, p.LastName, cr.CreditScore
FROM tblCreditReports cr
JOIN tblPeople p ON p.PersonID = cr.ClientID
WHERE cr.CreditScore > 740
ORDER BY cr.CreditScore DESC;

-- Business Question: What lenders are more likely to provide loans to clients with lower credit scores? 
-- What is the average credit scores for approved loans for each individual lender? How do the lenders compare? 
-- Show lenders who have approved clients with lowest scores first.

SELECT DISTINCT l.LenderID, LenderFirstName, LenderLastName, BankName, CreditScore, 
	(SELECT AVG(CreditScore) FROM tblCreditReports) as AvgCreditScore
FROM tblLenders l
JOIN tblCreditReports c ON l.LenderID = c.LenderID
JOIN tblLoans lo ON lo.LenderID = l.LenderID
WHERE l.LenderID IN (SELECT LenderID FROM tblLoans)
ORDER BY CreditScore;

/* Display clients with Totaldebt >= 25000 from the TblCreditReports */
-- Business Question: Which clients have a total debt of $25,000 or more?

SELECT p.FirstName, p.LastName, cr.TotalDebt
FROM tblCreditReports cr
JOIN tblPeople p ON p.PersonID = cr.ClientID
WHERE cr.TotalDebt >= 25000
ORDER BY cr.TotalDebt DESC;

/* Display all clients data from TblListings and NoBedrooms >= 3 AND NoBaths >= 2 AND SquareFt >= 1200 in desc order */
-- Business Question: What listings do we have for big houses? 

SELECT Street,City, TheState, ZipCode, NoBedrooms,NoBaths,SquareFt,PropetyTax,HOAFee,EstClosingCost,AppraisalAmount
FROM tblListings
WHERE NoBedrooms >= 3 AND NoBaths >= 2 AND SquareFt >= 1200
ORDER BY SquareFt DESC;

-- Business Question: Which clients estimated closing cost is larger than the average estimated closing cost for all clients? 

SELECT DISTINCT c.ClientID, p.FirstName, p.LastName, l.EstClosingCost, (SELECT AVG(EstClosingCost) FROM tblListings) AS AvgEstClosingCost
FROM tblClients c 
JOIN tblOffers o ON c.ClientID = o.ClientID
JOIN tblListings l ON o.ListingID = l.ListingID
JOIN tblPeople p ON c.ClientID = p.PersonID
WHERE EstClosingCost > (SELECT AVG(EstClosingCost) FROM tblListings);

-- Business Question: How many clients' income is larger than the average income for all the clients? 

SELECT DISTINCT c.ClientID, p.FirstName, p.LastName, c.Income, (SELECT AVG(Income) FROM tblClients) AS AvgIncome
FROM tblClients c 
JOIN tblPeople p ON c.ClientID = p.PersonID
WHERE Income > (SELECT AVG(Income) FROM tblClients)
ORDER BY Income DESC;

-- Business Question: Does it seem like most denied loans are for clients with lower than average incomes? 
-- Whether income is the reason that clients are denied

SELECT DISTINCT c.ClientID, p.FirstName, p.LastName, c.StageID, st.Stage, c.Income, (SELECT AVG(Income) FROM tblClients) AS AvgIncome
FROM tblClients c 
JOIN tblPeople p ON c.ClientID = p.PersonID
JOIN tblBuyingSellingStages st ON st.StageID = c.StageID
WHERE st.Stage = 'Denied'; 

/* 
Business Question: Real estate agents are interested in finding out which clients are interested in purchasing 
a house in a specific location but end up not buying a house there? They can then follow up with these clients 
to find out why they ended up not purchasing in this area. What clients were initially interested in 
San Diego but did not end up buying a house in San Diego?

What to know which clients are not interested in San diego properties but do end up buying a property in San Diego. 
*/

SELECT a.ClientID, p.FirstName, p.LastName
FROM (SELECT c.ClientID
	  FROM tblClients c
	  JOIN tblLocationsOfInterestForClients lc ON c.ClientID = lc.ClientID
	  JOIN tblLocationsOfInterest li ON lc.LocationOfInterestID = li.LocationOfInterestID
	  WHERE li.City = 'San Diego') a
JOIN (SELECT c.ClientID
	  FROM tblClients c
	  JOIN tblOffers o ON c.ClientID = o.ClientID
	  JOIN tblListings l ON o.ListingID = l.ListingID
	  WHERE l.City <> 'San Diego') b ON a.ClientID = b.ClientID
JOIN tblPeople p ON a.ClientID = p.PersonID;

