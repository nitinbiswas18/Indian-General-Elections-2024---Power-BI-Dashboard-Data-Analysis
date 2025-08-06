Create Table constituencywise_results
(
   S_No							int,
   Parliament_Constituency   	varchar(100)	Primary Key,
   Constituency_Name           varchar(100),
   Winning_Candidate   			varchar(150),
   Total_Votes					int,
   Margin						int,
   Constituency_ID				varchar(100),
   Party_ID						int
);

Select * from constituencywise_results;

--Drop table Partywise_results;--

Create Table states
(
   State_id		varchar(50)	Primary Key,
   State		varchar(100)
);

Select * from states;

Select state_id from states;


Create Table partywise_results
(
   Party		varchar(150),
   Won			int,
   Party_ID		int		primary Key
);

Select * from Partywise_results;

Select party,party_id from Partywise_results;


Create Table statewise_results
(
   Constituency					varchar(100),
   Const_No						int,
   Parliament_Constituency		varchar(100)	primary Key,
   Leading_Candidate			varchar(100),
   Trailing_Candidate			varchar(150),
   Margin						int,
   Status						varchar(100),
   State_ID						varchar(100),
   State						varchar(100)
);

Select * from statewise_results;

Select parliament_constituency,margin from statewise_results;

--Q. Total seats?

Select 	count(parliament_constituency) as Total_seat
from constituencywise_results;

--Q. what are the total number of seats available for election in each state?

Select
s.state as state_name,
count (cr.parliament_constituency) as total_seats
From
constituencywise_results cr 
Inner join statewise_results sr on cr.parliament_constituency = sr.parliament_constituency
Inner join states s on sr.state_id = s.state_id
Group by s.state
Order by total_seats desc;

--Q. Total seats won by NDA Alliance?

Select
	Sum(Case
			When party in (
			'Bharatiya Janata Party - BJP',
			'Telugu Desam - TDP',
			'Janata Dal  (United) - JD(U)',
			'Shiv Sena - SHS',
			'AJSU Party - AJSUP',
			'Apna Dal (Soneylal) - ADAL',
			'Asom Gana Parishad - AGP',
			'Hindustani Awam Morcha (Secular) - HAMS',
			'Janasena Party - JnP',
			'Janata Dal  (Secular) - JD(S)',
			'Lok Janshakti Party(Ram Vilas) - LJPRV',
			'Nationalist Congress Party - NCP',
			'Rashtriya Lok Dal - RLD',
			'Sikkim Krantikari Morcha - SKM'
			) then Won
			Else 0
			End
		) AS NDA_Total_seats_won
From
	partywise_results;
	
--Q. Seats won by NDA Alliance Parties?

Select
	party as Party_name,
	won as Seats_won
From
	partywise_results
Where
	party in (
			'Bharatiya Janata Party - BJP',
			'Telugu Desam - TDP',
			'Janata Dal  (United) - JD(U)',
			'Shiv Sena - SHS',
			'AJSU Party - AJSUP',
			'Apna Dal (Soneylal) - ADAL',
			'Asom Gana Parishad - AGP',
			'Hindustani Awam Morcha (Secular) - HAMS',
			'Janasena Party - JnP',
			'Janata Dal  (Secular) - JD(S)',
			'Lok Janshakti Party(Ram Vilas) - LJPRV',
			'Nationalist Congress Party - NCP',
			'Rashtriya Lok Dal - RLD',
			'Sikkim Krantikari Morcha - SKM'
			) 
Order by Seats_won Desc;

--Total seats won by I.N.D.I.A alliance?

Select
	Sum(Case
			When party in (
			'Indian National Congress - INC',
			'Aam Aadmi Party - AAAP',
			'All India Trinamool Congress - AITC',
			'Bharat Adivasi Party - BHRTADVSIP',
			'Communist Party of India - CPI',
			'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
			'Communist Party of India  (Marxist) - CPI(M)',
			'Dravida Munnetra Kazhagam - DMK',
			'Indian Union Muslim League - IUML',
			'Jammu & Kashmir National Conference - JKN',
			'Jharkhand Mukti Morcha - JMM',
			'Kerala Congress - KEC',
			'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
			'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
			'Rashtriya Janata Dal - RJD',
			'Rashtriya Loktantrik Party - RLTP',
			'Revolutionary Socialist Party - RSP',
			'Samajwadi Party - SP',
			'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
			'Viduthalai Chiruthaigal Katchi - VCK'
			) then Won
			Else 0
			End
		) AS INDIA_Total_seats_won
From
	partywise_results;

--Seats won by INDIA alliance Parties--

Select
	party as party_name,
	won as seats_won
From
	partywise_results
where
	party in (
			'Indian National Congress - INC',
			'Aam Aadmi Party - AAAP',
			'All India Trinamool Congress - AITC',
			'Bharat Adivasi Party - BHRTADVSIP',
			'Communist Party of India - CPI',
			'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
			'Communist Party of India  (Marxist) - CPI(M)',
			'Dravida Munnetra Kazhagam - DMK',
			'Indian Union Muslim League - IUML',
			'Jammu & Kashmir National Conference - JKN',
			'Jharkhand Mukti Morcha - JMM',
			'Kerala Congress - KEC',
			'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
			'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
			'Rashtriya Janata Dal - RJD',
			'Rashtriya Loktantrik Party - RLTP',
			'Revolutionary Socialist Party - RSP',
			'Samajwadi Party - SP',
			'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
			'Viduthalai Chiruthaigal Katchi - VCK'	
	)
Order by seats_won desc;

--Q. Add new column feild in table partywise_results to get the party Allianz as NDA,I.N.D.I.A and others.

Alter table partywise_results
	Add party_alliance 	varchar(50)

Update partywise_results
Set party_alliance = 'I.N.D.I.A'
Where 
	party in (
			'Indian National Congress - INC',
			'Aam Aadmi Party - AAAP',
			'All India Trinamool Congress - AITC',
			'Bharat Adivasi Party - BHRTADVSIP',
			'Communist Party of India - CPI',
			'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
			'Communist Party of India  (Marxist) - CPI(M)',
			'Dravida Munnetra Kazhagam - DMK',
			'Indian Union Muslim League - IUML',
			'Jammu & Kashmir National Conference - JKN',
			'Jharkhand Mukti Morcha - JMM',
			'Kerala Congress - KEC',
			'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
			'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
			'Rashtriya Janata Dal - RJD',
			'Rashtriya Loktantrik Party - RLTP',
			'Revolutionary Socialist Party - RSP',
			'Samajwadi Party - SP',
			'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
			'Viduthalai Chiruthaigal Katchi - VCK'	
	);

Update partywise_results
Set party_alliance = 'NDA'
Where
	party in (
			'Bharatiya Janata Party - BJP',
			'Telugu Desam - TDP',
			'Janata Dal  (United) - JD(U)',
			'Shiv Sena - SHS',
			'AJSU Party - AJSUP',
			'Apna Dal (Soneylal) - ADAL',
			'Asom Gana Parishad - AGP',
			'Hindustani Awam Morcha (Secular) - HAMS',
			'Janasena Party - JnP',
			'Janata Dal  (Secular) - JD(S)',
			'Lok Janshakti Party(Ram Vilas) - LJPRV',
			'Nationalist Congress Party - NCP',
			'Rashtriya Lok Dal - RLD',
			'Sikkim Krantikari Morcha - SKM'
		);
		
Update partywise_results
Set party_alliance = 'OTHER'
Where 
	party_alliance IS Null;

Select party_alliance,
Sum(won)
From 
	partywise_results
Group by
	party_alliance;

Select party,won
From 
	partywise_results
where
	party_alliance = 'NDA'
Order by won desc;

--Q. Winning candidate Name,party name,total votes and margin of victory for a specific state and constituency.

Select cr.winning_candidate,pr.party,cr.total_votes,cr.margin,s.state,cr.constituency_name
From
	constituencywise_results cr Inner join partywise_results pr On cr.party_id = pr.party_id
	Inner join statewise_results sr on cr.parliament_constituency = sr.parliament_constituency
	Inner join states s on sr.state_id = s.state_id
Where 
	cr.constituency_name = 'NALANDA';

--Q. What is the distribution of EVM votes vs Postal votes for candidate in a specific constituency?

Select cd.evm_votes,cd.postal_votes,cd.total_votes,cd.candidate,cr.constituency_name
From
	constituencywise_results cr Inner join constituencywise_details cd on cr.constituency_id = cd.constituency_id
Where
	cr.constituency_name = 'AMETHI';



