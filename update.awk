#!/usr/bin/gawk -f

function ROUND_OFF_TO_NEAREST_INTEGER(NUMBER)
{
	if(NUMBER < (int(NUMBER)+0.5)) return int(NUMBER)
	else return int(NUMBER)+1
}

function NUMBER_OF_DAYS(YEAR)
{
	if(YEAR%100==0)
	{
		if(YEAR%400==0) return 366
		else return 365
	}
	else if(YEAR%4==0) return 366
	else return 365
}

function LAST_DAY(YEAR)
{
	return mktime(YEAR" 12 31 00 00 00")
}

BEGIN{
	FS = ":"
	PREVIOUS_RECORD_DATE = 0
	PREVIOUS_BALANCE = 0
	PRINT_FLAG = 1
	INTEREST = 0
	PREVIOUS_RECORD_YEAR = -1
	INTEREST_RATE = 0.05
	COUNT = 0
}

/^((([0-2][0-9])|(3[0-1]))-(0[0-9]|1[0-2])-[0-9][0-9][0-9][0-9]:((((([0-9]+):)|(:([0-9]+))):([0-9]*):([A-Z ]+))|(::[0-9]+:ACCOUNT OPENED)))/{
	COUNT += 1
	DATE = $1
	split(DATE, DATE_ARR , "-")
	CURRENT_RECORD_DAY = int(DATE_ARR[1])
	CURRENT_RECORD_MONTH = int(DATE_ARR[2])
	CURRENT_RECORD_YEAR = int(DATE_ARR[3])
	CURRENT_RECORD_DATE = mktime(CURRENT_RECORD_YEAR" "CURRENT_RECORD_MONTH" "CURRENT_RECORD_DAY" 00 00 00")
	CREDIT = int($2)
	DEBIT = int($3)
	TRANSACTION_TYPE = $5
	gsub("\r","",TRANSACTION_TYPE)
	
	if((PREVIOUS_RECORD_YEAR != -1) && (PREVIOUS_RECORD_YEAR != CURRENT_RECORD_YEAR))
	{
		if(index(TRANSACTION_LOG[COUNT-1],"INTEREST")==0)
		{
			INTEREST += ((LAST_DAY(PREVIOUS_RECORD_YEAR)-PREVIOUS_RECORD_DATE)/86400)*INTEREST_RATE*PREVIOUS_BALANCE/NUMBER_OF_DAYS(int(PREVIOUS_RECORD_YEAR)) 
			INTEREST = ROUND_OFF_TO_NEAREST_INTEGER(INTEREST)
			PREVIOUS_BALANCE = PREVIOUS_BALANCE + INTEREST
			print "December 31, " PREVIOUS_RECORD_YEAR "   \tCredit of " INTEREST " for INTEREST      \tBalance = " PREVIOUS_BALANCE  
			TRANSACTION_LOG[COUNT] = "31-12-" PREVIOUS_RECORD_YEAR ":" INTEREST "::" PREVIOUS_BALANCE ":INTEREST"
			COUNT = COUNT + 1
		}
		INTEREST = 0
	}
	else INTEREST = INTEREST + ((CURRENT_RECORD_DATE-PREVIOUS_RECORD_DATE)/86400)*INTEREST_RATE*PREVIOUS_BALANCE/NUMBER_OF_DAYS(int(CURRENT_RECORD_YEAR))
	
	CURRENT_BALANCE = PREVIOUS_BALANCE + CREDIT - DEBIT
	if(TRANSACTION_TYPE ~ /ACCOUNT OPENED/) CURRENT_BALANCE = int($4)
	if($4=="")
	{
		if(PRINT_FLAG)
		{
			PRINT_FLAG = 0
			print "+++ New transactions found"
			print "Last balance = " PREVIOUS_BALANCE
		}
		if(CREDIT!=0) print strftime("%B %d %Y     ",CURRENT_RECORD_DATE) "\tCredit of " CREDIT " for " TRANSACTION_TYPE "      \tBalance = " CURRENT_BALANCE
		else if(DEBIT!=0)print strftime("%B %d %Y     ",CURRENT_RECORD_DATE) "\tDebit of " DEBIT " for " TRANSACTION_TYPE " \tBalance = " CURRENT_BALANCE
	}
	
	TRANSACTION_LOG[COUNT] = DATE ":" $2 ":" $3 ":" CURRENT_BALANCE ":" TRANSACTION_TYPE
	
	PREVIOUS_RECORD_DATE = CURRENT_RECORD_DATE
	PREVIOUS_BALANCE = CURRENT_BALANCE
	PREVIOUS_RECORD_YEAR = CURRENT_RECORD_YEAR
}

END{
	if(PRINT_FLAG) print "+++ No new transactions found"
	print "+++ Interest of this year up to the last transaction = " ROUND_OFF_TO_NEAREST_INTEGER(INTEREST)
	for(ITR=1;ITR<COUNT;++ITR) 
	{
		printf(TRANSACTION_LOG[ITR]) > "account.txt"
		printf("\n") > "account.txt"
	}
	printf(TRANSACTION_LOG[COUNT]) > "account.txt"
	printf("\n") > "account.txt"
}
