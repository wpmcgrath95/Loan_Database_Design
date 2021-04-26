/*
create sql database with sql
create docker container that creates sql database and lets user query through database
*/

USE MASTER; 

/*********************************************************************/
/* !!!!  SELECT THE CODE TO REFRESH THE DATABASE STARTING HERE  !!!! */
/*********************************************************************/
/*---------------------------------------------------------------------*/	 
/* If the RealEstate Database exists, DROP it so the lesson can begin  */
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
CREATE TABLE tblPeople
(
	PersonID	int             PRIMARY KEY,
	FirstName	varchar(64)     NOT NULL   ,
	LastName	varchar(64)	    NOT NULL   ,
	PhoneNumber varchar(64)	
);

INSERT INTO tblPeople VALUES   
(1001, 'Phil'   , 'Collins' , '6195559900'),
(1002, 'Ted'    , 'Mosley'  , '2125554000'),
(1003, 'Elvis'  , 'Costello', '4205550000'),
(1004, 'Ryan'   , 'Gosling' , '8225555678'),
(1005, 'Juan'   , 'Hornito' , '5605555031'),
(1006, 'John'   , 'Legend'  , '2845555000'),
(1007, 'Bill'   , 'Ernie'   , '3455559123'),
(1008, 'Beyance', 'Johnson' , '3345559031'),
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
/*              Create the COMPANY table	          		  */
/*------------------------------------------------------------*/
CREATE TABLE tblCompany	
(
	CompanyID		int				 PRIMARY KEY    ,	
	CompanyName		varchar(128)				    ,	
	Street   		varchar(128)	 UNIQUE	NOT NULL,
	City			varchar(128)				    ,
	TheState	    varchar(128)				    ,
	Zipcode		    varchar(128)				    ,
);

INSERT INTO tblCompany VALUES
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
/*             Create the REAL ESTATE AGENT table	          */
/*------------------------------------------------------------*/
CREATE TABLE tblRealEstateAgent
(
	AgentID 	int              PRIMARY KEY        REFERENCES tblPeople , -- Setup a column and designate it as primary key
	RSLicenseNo	varchar(64)      UNIQUE NOT NULL                         , -- Alternative Key
	Region 	    varchar(128)	                                         , 
	CompanyID   int	                                REFERENCES tblCompany		
);

INSERT INTO tblRealEstateAgent VALUES  
(1001, '#20004559', 'Northeast'   , 10001),  
(1002, '#30908579', 'Southwest'   , 10001),    
(1003, '#44004559', 'Central'     , 10003),   
(1004, '#70024355', 'Southeast'   , 10007),  
(1005, '#90112456', 'Northwest'   , 10007),    
(1006, '#10002233', 'Northeast'   , 10004),    
(1007, '#20003455', 'Mid-Atlantic', 10010),   
(1008, '#34556459', 'Northwast'   , 10009), 
(1009, '#80007411', 'Central'     , 10005),
(1010, '#98217411', 'Central'     , 10008);  

/*------------------------------------------------------------*/
/*          Create the BUYING SELLING STAGES table	     	  */
/*------------------------------------------------------------*/
CREATE TABLE tblBuyingSellingStages
(   
	StageID		  int		        PRIMARY KEY,
	Stage         varchar(64)
);

INSERT INTO tblBuyingSellingStages VALUES
(100001, 'Started'),
(100002, 'Processing'),
(100003, 'Approved'),
(100004, 'Closed'),
(100005, 'Denied');

/*------------------------------------------------------------*/
/*               Create the LISTINGS table	     	 		  */
/*------------------------------------------------------------*/
CREATE TABLE tblListings
(	
	ListingID		   int  			 PRIMARY KEY							  ,
	AgentID            int               FOREIGN KEY REFERENCES tblRealEstateAgent,
	Street             varchar(64)		 UNIQUE	NOT NULL						  ,
	City               varchar(64)                                                ,
	TheState           varchar(64)                                                ,
	ZipCode            varchar(64)                                                ,  
	NoBedrooms		   varchar(64)											      ,
	NoBaths			   varchar(64)												  ,
	SquareFt           int														  ,
	PropetyTax		   int														  ,
	HOAFee			   int														  ,
	EstClosingCost     int														  ,
	AppraisalAmount    int
);

INSERT INTO tblListings VALUES
(1111, 1001, '1111 Banana Ave' , 'San Diego', 'CA', '92222', '4', '2', 120, 7000 , 1000, 18000, 500),
(1112, 1002, '2222 Apple Ave'  , 'San Diego', 'CA', '92212', '5', '3', 200, 7500 , 1500, 20500, 517),
(1113, 1003, '2232 Cat Ave'    , 'San Diego', 'CA', '92112', '2', '1', 100, 2000 , 950 , 16000, 450),
(1114, 1004, '2332 Peach Ave'  , 'San Diego', 'CA', '91112', '6', '3', 400, 10000, 700 , 30000, 650),
(1115, 1005, '3000 Pet Ave'    , 'San Diego', 'CA', '90002', '4', '1', 100, 6000 , 990 , 16500, 480),
(1116, 1006, '4200 Pile Ave'   , 'San Diego', 'CA', '91002', '6', '2', 300, 9500 , 1000, 29000, 620),
(1117, 1007, '3333 Holiday Ave', 'San Diego', 'CA', '91000', '2', '2', 120, 4900 , 1100, 18500, 475);

/*------------------------------------------------------------*/
/*               Create the CLIENTS table	          		  */
/*------------------------------------------------------------*/
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

INSERT INTO tblClients VALUES
(1011, 1990-01-10              , '123 Olive St'        , 'San Diego'  , 'CA'             , '92101', 'San Diego'     , 'F', '000-12-0000', 50000  , 
	   'County of SD'          , 'Social Worker'       , 'Buy'        , '500,000-650,000', 2      , 'Townhome'      , 1  , 0            , 100001),
(1012, 1982-07-28              , '733 Grand Ave'       , 'Chula Vista', 'CA'             , '91910', 'San Diego'     , 'F', '000-13-0000', 120000 , 
	   'Amazon'                , 'Data Analyst'        , 'Buy'        , '700,000-800,000', 3      , 'Full Size Home', 1  , 1            , 100001),
(1013, 1967-07-04              , '3940 Emerald Ln #304', 'Yuma'       , 'AZ'			 , '85364', 'San Diego'     , 'M', '000-14-0000', 60000  , 
	   'Yuma Medical Center'   , 'Patient Rep'         , 'Buy'	      , '2,000-2,500'	 , 2      , 'Apartment'     , 0  , 0			, 100002),
(1014, 1995-02-30              , '134 Manhattan Ave'   , 'New York'   , 'NY'             , '10001', 'New York'      , 'F', '000-15-0000', 70000  , 
	   'Northwell Health'      , 'Registered Nurse'    , 'Buy'        , '2,000-2,500'    , 1      , 'Apartment'	 	, 0  , 0            , 100003),
(1015, 1977-08-28              , '589 Harmony Grove'   , 'Portland'   , 'OR'             , '97219', 'Portland'      , 'F', '000-16-0000', 50000  , 
	   'Portland State College', 'Research Assistant'  , 'Buy'        , '1,800-2,000'    , 1      , 'Apartment'		, 1  , 0            , 100004),
(1016, 1970-04-20              , '1546 Homan Ave'      , 'Chicago'    , 'IL'             , '60623', 'Chicago'       , 'F', '000-17-0000', 150000 , 
	   'Chicago Family Health' , 'Physician Assistant' , 'Buy'        , '750,000-850,000', 4      , 'Full Size Home', 1  , 0            , 100001),
(1017, 1980-10-25              , '435 Hummingbird Ln'  , 'Carlsbad'   , 'CA'             , '92009', 'San Diego'     , 'M', '000-18-0000', 90000  , 
	   'ViaSat'			       , 'UX Designer'         , 'Buy'        , '600,000-700,000', 5      , 'Full Size Home', 1  , 1            , 100005),
(1018, 1978-03-05              , '5031 Richardson Dr'  , 'Portland'   , 'OR'             , '97239', 'Portland'      , 'M', '000-19-0000', 180000 , 
	   'Microsoft'             , 'Hardware Engineer'   , 'Buy'        , '800,000-950,000', 3      , 'Full Size Home', 1  , 1            , 100003),
(1019, 1994-12-15              , '1234 Olive Dr'       , 'Los Angeles', 'CA'             , '90001', 'Los Angeles'   , 'M', '000-20-0000', 180000 , 
	   'Facebook'              , 'Software Engineer'   , 'Buy'        , '800,000-950,000', 2      , 'Full Size Home', 1  , 1            , 100003),
(1020, 1985-11-20              , '5774 Llamas Dr'      , 'Mira Mesa'  , 'CA'             , '92126', 'San Diego'     , 'F', '000-21-0000', 120000 , 
	   'Qualcomm'              , 'Data Scientist'      , 'Buy'        , '700,000-900,000', 3      , 'Full Size Home', 1  , 1            , 100003);

/*------------------------------------------------------------*/
/*            Create the BUYING OR SELLING table	          */
/*------------------------------------------------------------*/
CREATE TABLE tblBuyingOrSelling
(
	AgentID 				int 			 PRIMARY KEY REFERENCES tblRealEstateAgent,
	ClientID 				int 			 REFERENCES tblClients					  ,
	BuyingOrSellingInd  	varchar(64)
); 

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
/*     	  	Create the LOCATION OF INTEREST table	          */
/*------------------------------------------------------------*/
CREATE TABLE tblLocationsOfInterest
(
	LocationOfInterestID		int				PRIMARY KEY,	
	City						varchar(128)	NOT NULL   ,	
	Zipcode						int				NOT NULL
);

INSERT INTO tblLocationsOfInterest VALUES
(2001, 'Seattle'  , '58125'),
(2002, 'San Diego', '91282'), 
(2003, 'Riverside',	'92154'),		
(2004, 'Portland' , '51248'),		
(2005, 'Burbank'  , '44571'),
(2006, 'Miami'    , '21054'),	
(2007, 'Las Vegas', '57521'), 	
(2008, 'Sedona'   , '51672'),		
(2009, 'Phoenix'  , '51214'),		
(2010, 'San Diego', '92414');

/*------------------------------------------------------------*/
/*     Create the LOCATION OF INTEREST FOR CLIENTS table	  */
/*------------------------------------------------------------*/
CREATE TABLE tblLocationOfInterestsForClients
(
	ClientID	               int		      PRIMARY KEY REFERENCES tblClients,
	LocationOfInterestID       int            REFERENCES tblLocationsOfInterest, 
	InterestRank               varchar(64)    NOT NULL
);

INSERT INTO tblLocationOfInterestsForClients VALUES
(1010, 2001, 'Primary Choice'),
(1001, 2005, 'Primary Choice'),
(1008, 2007, 'Primary Choice'),
(1008, 2001, 'Secondary Choice'),
(1006, 2009, 'Primary Choice'),
(1003, 2006, 'Primary Choice'),
(1003, 2008, 'Secondary Choice'),
(1003, 2002, 'Third Choice'),
(1017, 2003, 'Primary Choice'),
(1017, 2001, 'Secondary Choice'),
(1014, 2004, 'Primary Choice');

/*------------------------------------------------------------*/
/*             Create the SALES CONTRACTS table	              */
/*------------------------------------------------------------*/
CREATE TABLE tblSalesContracts 
(
	SalesContractID 	int               PRIMARY KEY,
	PaymentMethod	    varchar(64)       NOT NULL   ,
);

INSERT INTO tblSalesContracts VALUES   
(01001, 'Bank Transfer'),  
(01002, 'Check'),    
(01003, 'Wire Transfer'),   
(01004, 'Cash'),  
(01005, 'Bank Transfer'),    
(01006, 'Credit Card'),    
(01007, 'Bank Transfer'),   
(01008, 'Check'), 
(01009, 'Bank Transfer'),
(01010, 'Bank Transfer');

/*------------------------------------------------------------*/
/*              Create the OFFERS table	          			  */
/*------------------------------------------------------------*/
CREATE TABLE tblOffers 
(
	ClientID      		int   			PRIMARY KEY REFERENCES  	   tblClients, 
	ListingID     		int   			REFERENCES               	  tblListings, 
	OfferAmount   		varchar(64)        							     		 , 
	OfferStatus   		varchar(64)		NOT NULL								 ,
	SalesContractID		int  			REFERENCES 				tblSalesContracts
);
	 	
-- NEED TO CHANGE VALUES
INSERT INTO tblOffers VALUES
(1010, 1234, '300000', 'In Progress', 11001),
(1011, 5678, '350000', 'In Progress', 11002),
(1012, 1324, '600000', 'Closed'     , 11003),
(1013, 4352, '430000', 'In Progress', 11004),
(1014, 4897, '250000', 'Closed'     , 11005),
(1015, 9074, '700000', 'Submitted'  , 11006),
(1016, 0901, '900000', 'Submitted'  , 11007),
(1017, 2314, '670000', 'Submitted'  , 11008),
(1018, 8683, '830000', 'In Progress', 11009),
(1019, 0131, '320000', 'Accepted'   , 11010);

/*------------------------------------------------------------*/
/*             	  Create the LENDERS table	              	  */
/*------------------------------------------------------------*/
CREATE TABLE tblLenders
(
	LenderID 	   		 int              PRIMARY KEY    ,
	LenderFirstName		 varchar(64) 				     ,
	LenderLasttName		 varchar(64) 				     ,
	BankName	         varchar(64)      NOT NULL       ,
	Street       		 varchar(64)	  UNIQUE NOT NULL,
	City                 varchar(64)                     ,
	TheState             varchar(64)                     ,
	ZipCode              varchar(64)                     ,
	BankType			 varchar(64)	  NOT NULL       ,
);

INSERT INTO tblLenders VALUES
(1101, 'Bill'   , 'Myers'    , 'Bank Of America'   , '111 Fig Ave'       , 'San Diego'  , 'CA', '91913', 'Commercial'),
(1102, 'John'   , 'Newman'   , 'Old Bank'          , '100 Old Rd'        , 'San Diego'  , 'CA', '91910', 'Commercial'),
(1103, 'Sarah'  , 'Johnson'  , 'Chase'             , '320 New Rd'        , 'Los Angeles', 'CA', '90001', 'Commercial'),
(1104, 'Liana'  , 'McMan'    , 'New Bank'          , '823 Banana Ave'    , 'San Diego'  , 'CA', '91913', 'Private'),
(1105, 'Michael', 'Jordan'   , 'Wells Fargo'       , '145 Adams Ave'     , 'San Diego'  , 'CA', '91913', 'Commercial'),
(1106, 'Chris'  , 'Murphy'   , 'US Bank'           , '1654 Ranch Dr'     , 'San Diego'  , 'CA', '91913', 'Commercial'),
(1107, 'Adam'   , 'Gilchrist','Silicon Valley Bank', '971 Ryan Dr'       , 'San Diego'  , 'CA', '91913', 'Private'),
(1108, 'Ian'    , 'Healy'    , 'Chase'             , '747 Calaveras Blvd', 'San Diego'  , 'CA', '91915', 'Commercial'),
(1109, 'Kayla'  , 'Wright'   , 'Bank of America'   , '111 Fig Ave'       , 'San Diego'  , 'CA', '91913', 'Commercial'),
(1110, 'Joana'  , 'Quiles'   , 'Chase'             , '320 New Rd'        , 'Los Angeles', 'CA', '90001', 'Commercial');

/*------------------------------------------------------------*/
/*              Create the LOANS table	          			  */
/*------------------------------------------------------------*/
CREATE TABLE tblLoans 
(
	LoanID	              int			  PRIMARY KEY				  ,
	InterestRate          decimal(4,2)              				  ,
	TypeofLoan            varchar(64)     NOT NULL   				  , --Business Rules state must be fully documented
	Amount                int             NOT NULL   				  , --Business Rules state must be fully documented
	ExpirationDate        date            NOT NULL   				  , --Business Rules state must be fully documented
	MortgageType          varchar(64)     NOT NULL   				  , --Business Rules state must be fully documented
	DateOfSanction        date            NOT NULL   				  , --Business Rules state must be fully documented
	DateOfDisbursement    date            NOT NULL   				  , --Business Rules state must be fully documented
	DownPayment           int             NOT NULL   				  , --Business Rules state must be fully documented
	PMI                   int                           			  ,
	SalesContractID       int             REFERENCES tblSalesContracts,
	LenderID              int             REFERENCES tblLender
);

INSERT INTO tblLoans VALUES
(10105, 08.25, 'Mortgage', 550000 , 2049-02-04, 'Fixed Rate'   , 2019-02-04, 2019-04-01, 110000, 0   , 01001, 1103),
(10106, 06.50, 'Mortgage', 300000 , 2049-03-21, 'Fixed Rate'   , 2019-03-20, 2019-05-20, 75000 , 0   , 01002, 1102),
(10107, 07.45, 'Mortgage', 1225000, 2049-06-14, 'Fixed Rate'   , 2019-06-14, 2019-07-20, 183750, 500 , 01003, 1108),
(10108, 06.50, 'Mortgage', 650000 , 2034-06-20, 'FHA'          , 2019-06-18, 2019-08-25, 110000, 0   , 01004, 1107),
(10109, 10.00, 'Mortgage', 825000 , 2034-08-15, 'Interest Only', 2019-08-15, 2019-09-15, 0     , 0   , 01005, 1108),
(10110, 04.25, 'Mortgage', 250000 , 2050-01-05, 'Fixed Rate'   , 2020-01-04, 2020-04-01, 12500 , 1000, 01006, 1102),
(10111, 04.50, 'Mortgage', 750000 , 2050-04-20, 'Fixed Rate'   , 2020-04-17, 2020-05-08, 150000, 0   , 01007, 1105),
(10112, 03.25, 'Mortgage', 945000 , 2050-07-28, 'Fixed Rate'   , 2020-07-28, 2020-08-21, 9450  , 1200, 01008, 1103),
(10113, 05.00, 'Mortgage', 600000 , 2050-10-25, 'VA'           , 2020-10-24, 2020-12-01, 30000 , 0   , 01009, 1109),
(10114, 03.00, 'Mortgage', 250000 , 2051-01-04, 'FHA'          , 2021-01-04, 2021-04-01, 62500 , 0   , 01010, 1102);

/*------------------------------------------------------------*/
/*              Create the CREDIT REPORTS table	              */
/*------------------------------------------------------------*/
CREATE TABLE tblCreditReports 
(
	CreditReportID	       int		 		 PRIMARY KEY          ,
	CreditLine             varchar(64)                            ,
	TotalDebt              int                                    ,
	CreditScore            varchar(64)                            ,
	CurrentMortgage        varchar(64)                            ,
	ChildSupport           varchar(64)                     		  ,
	OtherLinesOfSupport    varchar(64) 		                      ,
	CurrentBalance         int                                    ,
	ClientID               int  			 REFERENCES tblClients,
	LenderID               int  			 REFERENCES tblLender ,

);

INSERT INTO tblCreditReports VALUES
(30001, '100000', 55000, '777', '0'    , '3000', '1000', 10000, 1011, 1101),
(30002, '200000', 15000, '790', '20000', '0'   , '500' , 2000 , 1012, 1108),
(30003, '150000', 50000, '700', '0'    , '1000', '700' , 15000, 1013, 1102),
(30004, '400000', 40000, '792', '10000', '500' , '1000', 25000, 1014, 1104),
(30005, '125000', 25000, '698', '0'    , '0'   , '0'   , 7000 , 1015, 1105),
(30006, '500000', 45000, '715', '50000', '0'   , '600' , 17000, 1016, 1107),
(30007, '650000', 30000, '780', '25000', '0'   , '200' , 5500 , 1017, 1109),
(30008, '650000', 30000, '780', '30000', '0'   , '200' , 500  , 1018, 1103),
(30009, '650000', 30000, '780', '10000', '0'   , '1000', 1000 , 1019, 1106),
(30010, '650000', 30000, '780', '0'    , '0'   , '500' , 3000 , 1020, 1110);

GO