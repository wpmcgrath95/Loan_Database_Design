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
	FirstName	varchar (64)    NOT NULL   ,
	LastName	varchar (64)	NOT NULL   ,
	PhoneNumber varchar (64)	
);

INSERT INTO tblPeople VALUES   
(1001, 'Phil'    ,   'Collins'    ,     '6195559900'),
(1002, 'Ted'     ,   'Mosley'     ,     '2125554000'),
(1003, 'Elvis'   ,   'Costello'   ,     '4205550000'),
(1004, 'Ryan'    ,   'Gosling'    ,     '8225555678'),
(1005, 'Juan'    ,   'Hornito'    ,     '5605555031'),
(1006, 'John'    ,   'Legend'     ,     '2845555000'),
(1007, 'Bill'    ,   'Ernie'      ,     '3455559123'),
(1008, 'Beyance' ,   'Johnson'    ,     '3345559031'),
(1009, 'Robert'  ,   'Briggs'     ,     '8585555401');

/*------------------------------------------------------------*/
/*             Create the REAL ESTATE AGENT table	          */
/*------------------------------------------------------------*/
CREATE TABLE tblRealEstateAgent
(
	AgentID 	int              PRIMARY KEY        REFERENCES tblPEOPLE  , -- Setup a column and designate it as primary key
	RSLicenseNo	varchar (64)     UNIQUE NOT NULL                          , -- Alternative Key
	Region 	    varchar (128)	                                          , 
	CompanyID   int	                                REFERENCES tblCOMPANY		
);

INSERT INTO tblRealEstateAgent VALUES   
(1001, '#20004559'  ,   'Northeast'    , 10001),  
(1002, '#30908579'  ,   'Southwest'    , 10001),    
(1003, '#44004559'  ,   'Central'      , 10003),   
(1004, '#70024355'  ,   'Southeast'    , 10007),  
(1005, '#90112456'  ,   'Northwest'    , 10007),    
(1006, '#10002233'  ,   'Northeast'    , 10004),    
(1007, '#20003455'  ,   'Mid-Atlantic' , 10010),   
(1008, '#34556459'  ,   'Northwast'    , 10009), 
(1009, '#80007411'  ,   'Central'      , 10005);  

/*------------------------------------------------------------*/
/*          Create the BUYING SELLING STAGES table	     	  */
/*------------------------------------------------------------*/
CREATE TABLE tblBuyingSellingStages
(   
	StageID		  int		        PRIMARY KEY,
	Stage         varchar(64)
);

INSERT INTO tblBuyingSellingStages VALUES
(1000, 'Started'),
(2000, 'Processing'),
(3000, 'Approved');

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
(1111, 1001, '1111 Banana Avenue, San Diego, 92222'  , '4', '2', 120, 7000 , 1000, 18000, 500),
(1112, 1002, '2222 Apple Avenue, San Diego, 92212'   , '5', '3', 200, 7500 , 1500, 20500, 517),
(1113, 1003, '2232 Cat Avenue, San Diego, 92112'     , '2', '1', 100, 2000 , 950 , 16000, 450),
(1114, 1004, '2332 Peach Avenue, San Diego, 91112'   , '6', '3', 400, 10000, 700 , 30000, 650),
(1115, 1005, '3000 Pet Avenue, San Diego, 90002'     , '4', '1', 100, 6000 , 990 , 16500, 480),
(1116, 1006, '4200 PPP Avenue, San Diego, 91002'     , '6', '2', 300, 9500 , 1000, 29000, 620),
(1117, 1007, '3333 Holiday Avenue, San Diego, 91000' , '2', '2', 120, 4900 , 1100, 18500, 475);

/*------------------------------------------------------------*/
/*               Create the CLIENTS table	          		  */
/*------------------------------------------------------------*/
CREATE TABLE tblClients
(
	ClientID	           int			   PRIMARY KEY REFERENCES tblPEOPLE,
	DOB                    varchar(64)                                     ,
	Street       		   varchar(64)	   UNIQUE NOT NULL			       ,
	City                   varchar(64)                                     ,
	TheState               varchar(64)                                     ,
	ZipCode                varchar(64)                                     ,  
	Region          	   varchar(64)                                     ,
	Gender                 varchar(64)                                     ,
	SSN                    varchar(64)     UNIQUE                          ,
	Income                 int                                             ,
	PrimaryEmployer        varchar(64)                                     ,
	JobTitle               varchar(64)                                     ,
	BuyingIndicator        varchar(64)                                     ,
	PriceRange             varchar(64)                                     ,
	CurrentHouseholdSize   int                                             ,
	TypeofHome             varchar(64)                                     ,
	PoolInd                varchar(64)                                     ,
	HOAInd	               varchar(64)                                     ,
	StageID                int             REFERENCES tblBuyingOrSelling 
);

INSERT INTO tblClients VALUES
(1010, '01/10/1990', '123 Olive St’, ’San Diego', 'CA', '92101', 'San Diego', 'F', '000-12-0000', 50000, 
'County of SD', 'Social Worker','Buy', '500,000-650,000', 2, 'Townhome', 1, 0,  10010),
(1011, '07/28/1982', '733 Grand Ave’, ‘Chula Vista', 'CA', '91910', 'San Diego', 'F', '000-13-0000', 120000, 
'Amazon', 'Data Analyst', 'Buy', '700,000-800,000', 3, 'Full Size Home', 1, 1,  10011),
(1012, '07/04/1967', '3940 Emerald Ln #304', 'Yuma', 'AZ', '85364', 'Yuma', 'M', '000-14-0000', 60000, 
'Yuma Medical Center', 'Patient Rep', 'Rent', '2,000-2,500', 2, 'Apartment’', 0, 0,  10012),
(1013, '12/27/1998', '134 Manhattan Ave', 'New York', 'NY', '10001', 'New York', 'F', '000-15-0000', 70000, 
'Northwell Health', 'Registered Nurse', 'Rent', '2,000-2,500', 1, 'Apartment', 0, 0,  10013),
(1014, '08/28/1977', '589 Harmony Grove', 'Portland', 'OR', '97219', 'Portland', 'F', '000-16-0000', 50000, 
'Lewis and Clark College', 'Research Assistant', 'Rent', '1,800-2,000', 1, 'Apartment', 1, 0,  10014),
(1015, '04/20/1970', '1546 Homan Ave', 'Chicago', 'IL', '60623', 'Chicago', 'F', '000-17-0000', 150000, 
'Chicago Family Health', 'Physician Assistant', 'Buy', '750,000-850,000', 4, 'Full Size Home', 1, 0,  10015),
(1016, '04/03/1980', '435 Hummingbird Ln', 'Carlsbad', 'CA', '92009', 'San Diego', 'M', '000-18-0000', 90000, 
'ViaSat', 'UX Designer', 'Buy', '600,000-700,000', 5, 'Full Size Home', 1, 1,  10016),
(1017, '03/05/1960', '5031 Richardson Dr', 'Portland', 'OR', '97239', 'Portland', 'M', '000-19-0000', 180000, 
'Microsoft', 'Hardware Engineer', 'Buy', '800,000-950,000', 3, 'Full Size Home', 1, 1,  10017);

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
(1, 'Best Real Estate'   , '15746 Star Ave'  , 'Fremont'  , 'CA', '85748'),
(2, 'Best Homes'         , '75847 Home St'   , 'Burbank'  , 'CA', '84547'), 
(3, 'Corn Housing'       , '64520 Mask Blvd' , 'Houston'  , 'TX', '18446'),
(4, 'Housing for Free'   , '45712 Great Ave' , 'Miami'    ,	'FL', '75487'),
(5, 'Forever Homes'      , '74126 Up St'     , 'Seattle'  , 'WA', '74581'),
(6, 'No More Paying Rent', '65849 Roof Blvd' , 'Portland' , 'OR', '84751'),
(7, 'San Diego Homes'    , '5500 Camp St'    , 'San Diego',	'CA', '95219'),
(8, 'Roof Over'          , '54154 Oregon Ave', 'Phoenix'  ,	'AZ', '95421'),
(9, 'Agency For You'     , '24812 Bat St'    , 'Sedona'   , 'AZ', '94572'),
(10, 'Balloon Homes'     , '22750 Part Blvd' , 'Las Vegas', 'NV', '78421');

/*------------------------------------------------------------*/
/*     	  	Create the LOCATION OF INTEREST table	          */
/*------------------------------------------------------------*/
CREATE TABLE tblLocationsOfInterest
(
	LocationOfInterestID		int				PRIMARY KEY,	
	City						varchar(128)	NOT NULL,	
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
	ClientID	               int		      PRIMARY KEY REFERENCES tblClients            ,
	LocationofInterestID       int            PRIMARY KEY REFERENCES tblLocationsOfInterest,
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
/*             Create the SALES CONTRACTS table	              */
/*------------------------------------------------------------*/
CREATE TABLE tblSalesContracts 
(
	SalesContractID 	int               PRIMARY KEY,
	PaymentMethod	    varchar (64)      NOT NULL,
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
/*             	  Create the LENDERS table	              	  */
/*------------------------------------------------------------*/
CREATE TABLE tblLenders
(
	LenderID 	   		 int              PRIMARY KEY    ,
	LoanOfficerName		 varchar(64) 				     ,
	BankName	         varchar(64)      NOT NULL       ,
	Street       		 varchar(64)	  UNIQUE NOT NULL,
	City                 varchar(64)                     ,
	TheState             varchar(64)                     ,
	ZipCode              varchar(64)                     ,
	BankType			 varchar(64)	  NOT NULL       ,
);

INSERT INTO tblLenders VALUES
(); 

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
(10105, 08.25, 'Mortgage', 550000 , 2049-02-04, 'Fixed Rate'   , 2019-02-04, 2019-04-01, 110000, 0   , 01001, 103),
(10106, 06.50, 'Mortgage', 300000 , 2049-03-21, 'Fixed Rate'   , 2019-03-20, 2019-05-20, 75000 , 0   , 01002, 101),
(10107, 07.45, 'Mortgage', 1225000, 2049-06-14, 'Fixed Rate'   , 2019-06-14, 2019-07-20, 183750, 500 , 01003, 108),
(10108, 06.50, 'Mortgage', 650000 , 2034-06-20, 'FHA'          , 2019-06-18, 2019-08-25, 110000, 0   , 01004, 107),
(10109, 10.00, 'Mortgage', 825000 , 2034-08-15, 'Interest Only', 2019-08-15, 2019-09-15, 0     , 0   , 01005, 108),
(10110, 04.25, 'Mortgage', 250000 , 2050-01-05, 'Fixed Rate'   , 2020-01-04, 2020-04-01, 12500 , 1000, 01006, 102),
(10111, 04.50, 'Mortgage', 750000 , 2050-04-20, 'Fixed Rate'   , 2020-04-17, 2020-05-08, 150000, 0   , 01007, 105),
(10112, 03.25, 'Mortgage', 945000 , 2050-07-28, 'Fixed Rate'   , 2020-07-28, 2020-08-21, 9450  , 1200, 01008, 103),
(10113, 05.00, 'Mortgage', 600000 , 2050-10-25, 'VA'           , 2020-10-24, 2020-12-01, 30000 , 0   , 01009, 109),
(10114, 03.00, 'Mortgage', 250000 , 2051-01-04, 'FHA'          , 2021-01-04, 2021-04-01, 62500 , 0   , 01010, 102);

/*------------------------------------------------------------*/
/*              Create the CREDIT REPORTS table	              */
/*------------------------------------------------------------*/
CREATE TABLE tblCreditReports 
(
	CreditReportID	       int		 		 PRIMARY KEY          ,
	Creditline             varchar(64)                            ,
	DebtInfo               varchar(64)                            ,
	Creditscore            varchar(64)                            ,
	CurrentMortgage        varchar(64)                            ,
	Childsupport           varchar(64)       NULL                 ,
	Otherlinesofsupport    varchar(64) 		 NULL                 ,
	TradeLines             varchar(64)                            ,
	ClientID               int  			 REFERENCES tblClients,
	LenderID               int  			 REFERENCES tblLender ,

);

INSERT INTO tblCreditReports VALUES
(30001, '100000', '55000', '777', '0', '3000', '1000','', 1010, 20001);

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
(); 

GO