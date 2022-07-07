# Gawky-printer
### This is another fun project to write a program using AWK to print and update our passbook (along with the interest accrued) and show the changes made.


Let's say we have a bank account in the Foopradesh Bank of Barland😁. Our account starts with an opening balance on
a date. After that, our account undergoes a sequence of transactions. The transactions are as follows.
### Debit transactions
We make ATM withdrawals, e-payments to merchants, and bank transfers to other accounts.
### Credit transactions
Our salary is deposited to our account on the first day of every month.
On December 31 of every year, the bank deposits (yearly) interest to our account. The interest rate
is constant (5% per annum). If our account balance is B for n consecutive days, the interest is
computed at the rate of 5% for n days. If our balance changes to B' because of a debit from or a
credit to our account, the interest will be calculated on the updated balance for as long as the
balance remains B'. However, the interest is not deposited to our account until the last day of the
year. The interest should be maintained as a floating-point value. While depositing, the bank converts
it to the nearest integer by rounding. After this, our yearly interest for the next year is reset to zero.
Notice that the per-day interest is slightly lower in a leap year than it is in a non-leap year.

We need to update our passbook from time to time. Our bank maintains our account details in a central
server. However, for passbook printing at our local branch, the local server does not contact the central
server. The local server instead keeps a copy of our transactions in a text file account.txt. This file is always
kept sorted in the increasing order of the transaction dates. Each line of the file is a record of five fields
separated by colons.

`Date:Credit Amount:Debit Amount:Balance:Type of transaction`

When we open our account, only the following line is added to account.txt:

`22-10-2019:::31201:ACCOUNT OPENED`

This line means that we opened our account on Oct 22, 2019 with an opening balance of 31201. After that,
we make transactions to/from our account. These transactions are stored in the file account.txt without the
balance being calculated. For example, consider the following transactions on the first few days after
opening the account. Each transaction is either a credit transaction or a debit transaction, that is, exactly one
of the second and the third fields in each line should contain a positive integer, and the other field would be
empty. The file account.txt looks as follows.

`22-10-2019:::31201:ACCOUNT OPENED` <br>
`01-11-2019:61872:::SALARY` <br>
`02-11-2019::6924::EPAY TO MERCHANT` <br>
`06-11-2019::7000::ATM WITHDRAWAL` <br>
`08-11-2019::6160::BANK TRANSFER` <br>
`22-11-2019::4000::ATM WITHDRAWAL` <br>
`01-12-2019:61872:::SALARY` <br>
`03-12-2019::2467::BANK TRANSFER` <br>
`17-12-2019::4196::EPAY TO MERCHANT` <br>
`19-12-2019::3036::EPAY TO MERCHANT` <br>
`23-12-2019::4148::EPAY TO MERCHANT` <br>
`29-12-2019::2938::BANK TRANSFER` <br>
`01-01-2020:62832:::SALARY` <br>
`01-01-2020::4684::EPAY TO MERCHANT` <br>
`14-01-2020::11000::ATM WITHDRAWAL` <br>
`17-01-2020::11000::ATM WITHDRAWAL`

The entries from the second line do not have the balance field filled up. Morever, this file does not store the interest paid by
the bank on the last day of 2019 until we update our passbook. When we update our passbook, all the
missing balances are calculated, and the interest(s) deposited (if any) at the end of the year(s) is/are also
added. Therefore, if our update our passbook on January 20, 2020, the file account.txt updates as follows
(assume that there are no transactions after January 17, 2020). The new items added are in bold and italics.
The last line printed in italics is not added to account.txt.

`22-10-2019:::31201:ACCOUNT OPENED` <br>
`01-11-2019:61872::`***`93073`***`:SALARY` <br>
`02-11-2019::6924:`***`86149`***`:EPAY TO MERCHANT` <br>
`06-11-2019::7000:`***`79149`***`:ATM WITHDRAWAL` <br>
`08-11-2019::6160:`***`72989`***`:BANK TRANSFER` <br>
`22-11-2019::4000:`***`68989`***`:ATM WITHDRAWAL` <br>
`01-12-2019:61872::`***`130861`***`:SALARY` <br>
`03-12-2019::2467:`***`128394`***`:BANK TRANSFER` <br>
`17-12-2019::4196:`***`124198`***`:EPAY TO MERCHANT` <br>
`19-12-2019::3036:`***`121162`***`:EPAY TO MERCHANT` <br>
`23-12-2019::4148:`***`117014`***`:EPAY TO MERCHANT` <br>
`29-12-2019::2938:`***`114076`***`:BANK TRANSFER` <br>
***`31-12-2019:859::114935:INTEREST`*** <br>
`01-01-2020:62832::`***`177767`***`:SALARY` <br>
`01-01-2020::4684:`***`173083`***`:EPAY TO MERCHANT` <br>
`14-01-2020::11000:`***`162083`***`:ATM WITHDRAWAL` <br>
`17-01-2020::11000:`***`151083`***`:ATM WITHDRAWAL` <br>
*`+++ Interest of this year up to the last transaction = 374`*

Notice that the passbook printer, in addition to computing the balance after every transaction, also computes
the interest that we get in 2019, and adds a credit entry with the date 31-12-2019. The last line is not for
storing in the file account.txt. We may consider this as a user message shown to us on the display of the
passbook-printing machine.
Suppose that we make some other transactions after this passbook printing, and the file account.txt now
stores the following records.

`22-10-2019:::31201:ACCOUNT OPENED` <br>
`01-11-2019:61872::93073:SALARY` <br>
`02-11-2019::6924:86149:EPAY TO MERCHANT` <br>
`06-11-2019::7000:79149:ATM WITHDRAWAL` <br>
`08-11-2019::6160:72989:BANK TRANSFER` <br>
`22-11-2019::4000:68989:ATM WITHDRAWAL` <br>
`01-12-2019:61872::130861:SALARY` <br>
`03-12-2019::2467:128394:BANK TRANSFER` <br>
`17-12-2019::4196:124198:EPAY TO MERCHANT` <br>
`19-12-2019::3036:121162:EPAY TO MERCHANT` <br>
`23-12-2019::4148:117014:EPAY TO MERCHANT` <br>
`29-12-2019::2938:114076:BANK TRANSFER` <br>
`31-12-2019:859::114935:INTEREST` <br>
`01-01-2020:62832::177767:SALARY` <br>
`01-01-2020::4684:173083:EPAY TO MERCHANT` <br>
`14-01-2020::11000:162083:ATM WITHDRAWAL` <br>
`17-01-2020::11000:151083:ATM WITHDRAWAL` <br>
***`24-01-2020::10000::ATM WITHDRAWAL` <br>
`01-02-2020:62832:::SALARY` <br>
`08-02-2020::6000::ATM WITHDRAWAL` <br>
`12-02-2020::8667::EPAY TO MERCHANT` <br>
`24-02-2020::6357::BANK TRANSFER` <br>
`27-02-2020::9383::BANK TRANSFER` <br>
`01-03-2020:62832:::SALARY`***

The balances made after the last passbook printing are not calculated. On March 05, 2020, we update our
passbook again. At this point, the balances are updated, and the records are changed as follows. The new
items added are again in bold and italics. The interest is calculated but not deposited because that is done
only once at the end of the year.

`22-10-2019:::31201:ACCOUNT OPENED` <br>
`01-11-2019:61872::93073:SALARY` <br>
`02-11-2019::6924:86149:EPAY TO MERCHANT` <br>
`06-11-2019::7000:79149:ATM WITHDRAWAL` <br>
`08-11-2019::6160:72989:BANK TRANSFER` <br>
`22-11-2019::4000:68989:ATM WITHDRAWAL` <br>
`01-12-2019:61872::130861:SALARY` <br>
`03-12-2019::2467:128394:BANK TRANSFER` <br>
`17-12-2019::4196:124198:EPAY TO MERCHANT` <br>
`19-12-2019::3036:121162:EPAY TO MERCHANT` <br>
`23-12-2019::4148:117014:EPAY TO MERCHANT` <br>
`29-12-2019::2938:114076:BANK TRANSFER` <br>
`31-12-2019:859::114935:INTEREST` <br>
`01-01-2020:62832::177767:SALARY` <br>
`01-01-2020::4684:173083:EPAY TO MERCHANT` <br>
`14-01-2020::11000:162083:ATM WITHDRAWAL` <br>
`17-01-2020::11000:151083:ATM WITHDRAWAL` <br>
`24-01-2020::10000:`***`141083`***`:ATM WITHDRAWAL` <br>
`01-02-2020:62832::`***`203915`***`:SALARY` <br>
`08-02-2020::6000:`***`197915`***`:ATM WITHDRAWAL` <br>
`12-02-2020::8667:`***`189248`***`:EPAY TO MERCHANT` <br>
`24-02-2020::6357:`***`182891`***`:BANK TRANSFER` <br>
`27-02-2020::9383:`***`173508`***`:BANK TRANSFER` <br>
`01-03-2020:62832::`***`236340`***`:SALARY` <br>
*`+++ Interest of this year up to the last transaction = 1432`*

Our task is to write the software for the passbook printer. We use the gawk programming language to that
effect. our program named [`update.awk`](update.awk) should do the following.
1. Read the file account.txt which stores the transactions in the increasing sequence of dates. The date
of the last passbook printing is not stored. Once a blank entry is located in the balance field in a
record, all the remaining input lines starting from this line have blank balance entries.
2. If there are no new entries that need updates, a user message is displayed as follows.

    `+++ No new transactions found`

    On the other hand, if there are entries that need updates, the following user message is printed. Also,
the last balance before the first new transaction is printed.

    `+++ New transactions found`

3. The updated lines including new balances calculated and interests deposited (if any) are printed as
user messages. We use the format as described in the sample output shown.
4. The interest accrued so far is also printed as the last user message.
5. The old account.txt file is replaced by a new file (with the same name) to store the new records
starting from the day of opening the account and ending at the last transaction.
We assume that all user messages go to our terminal. That includes the beginning line in 2, the previous
balance, all updated lines of 3 (we do not print the lines that are updated earlier), and the final interest
notification of 4. In a real-life situation, we should also have a printer interface for writing the new lines (in
some format) to our passbook, but we do not do this now.
[`update.awk`](update.awk) should be run as
`$ ./update.awk account.txt` or `$ gawk -f ./update.awk account.txt`
without any redirection. The program will print the user messages to our terminal, and overwrite the old
file account.txt.
The behavior of our program for the second example of passbook printing mentioned earlier is given here:

The input file account.txt

`22-10-2019:::31201:ACCOUNT OPENED` <br>
`01-11-2019:61872::93073:SALARY` <br>
`02-11-2019::6924:86149:EPAY TO MERCHANT` <br>
`06-11-2019::7000:79149:ATM WITHDRAWAL` <br>
`08-11-2019::6160:72989:BANK TRANSFER` <br>
`22-11-2019::4000:68989:ATM WITHDRAWAL` <br>
`01-12-2019:61872::130861:SALARY` <br>
`03-12-2019::2467:128394:BANK TRANSFER` <br>
`17-12-2019::4196:124198:EPAY TO MERCHANT` <br>
`19-12-2019::3036:121162:EPAY TO MERCHANT` <br>
`23-12-2019::4148:117014:EPAY TO MERCHANT` <br>
`29-12-2019::2938:114076:BANK TRANSFER` <br>
`31-12-2019:859::114935:INTEREST` <br>
`01-01-2020:62832::177767:SALARY` <br>
`01-01-2020::4684:173083:EPAY TO MERCHANT` <br>
`14-01-2020::11000:162083:ATM WITHDRAWAL` <br>
`17-01-2020::11000:151083:ATM WITHDRAWAL` <br>
`24-01-2020::10000::ATM WITHDRAWAL` <br>
`01-02-2020:62832:::SALARY` <br>
`08-02-2020::6000::ATM WITHDRAWAL` <br>
`12-02-2020::8667::EPAY TO MERCHANT` <br>
`24-02-2020::6357::BANK TRANSFER` <br>
`27-02-2020::9383::BANK TRANSFER` <br>
`01-03-2020:62832:::SALARY`

What our program will print

`+++ New transactions found` <br>
`Last balance = 151083` <br>
`January 24, 2020 Debit of 10000 for ATM WITHDRAWAL Balance = 141083` <br>
`February 01, 2020 Credit of 62832 for SALARY Balance = 203915` <br>
`February 08, 2020 Debit of 6000 for ATM WITHDRAWAL Balance = 197915` <br>
`February 12, 2020 Debit of 8667 for EPAY TO MERCHANT Balance = 189248` <br>
`February 24, 2020 Debit of 6357 for BANK TRANSFER Balance = 182891` <br>
`February 27, 2020 Debit of 9383 for BANK TRANSFER Balance = 173508` <br>
`March 01, 2020 Credit of 62832 for SALARY Balance = 236340` <br>
`+++ Interest of this year up to the last transaction = 1432`

The updated file account.txt

`22-10-2019:::31201:ACCOUNT OPENED` <br>
`01-11-2019:61872::93073:SALARY` <br>
`02-11-2019::6924:86149:EPAY TO MERCHANT` <br>
`06-11-2019::7000:79149:ATM WITHDRAWAL` <br>
`08-11-2019::6160:72989:BANK TRANSFER` <br>
`22-11-2019::4000:68989:ATM WITHDRAWAL` <br>
`01-12-2019:61872::130861:SALARY` <br>
`03-12-2019::2467:128394:BANK TRANSFER` <br>
`17-12-2019::4196:124198:EPAY TO MERCHANT` <br>
`19-12-2019::3036:121162:EPAY TO MERCHANT` <br>
`23-12-2019::4148:117014:EPAY TO MERCHANT` <br>
`29-12-2019::2938:114076:BANK TRANSFER` <br>
`31-12-2019:859::114935:INTEREST` <br>
`01-01-2020:62832::177767:SALARY` <br>
`01-01-2020::4684:173083:EPAY TO MERCHANT` <br>
`14-01-2020::11000:162083:ATM WITHDRAWAL` <br>
`17-01-2020::11000:151083:ATM WITHDRAWAL` <br>
`24-01-2020::10000:141083:ATM WITHDRAWAL` <br>
`01-02-2020:62832::203915:SALARY` <br>
`08-02-2020::6000:197915:ATM WITHDRAWAL` <br>
`12-02-2020::8667:189248:EPAY TO MERCHANT` <br>
`24-02-2020::6357:182891:BANK TRANSFER` <br>
`27-02-2020::9383:173508:BANK TRANSFER` <br>
`01-03-2020:62832::236340:SALARY`

If we run update.awk again before any other transactions, our program will print:

`+++ No new transactions found ` <br>
`+++ Interest of this year up to the last transaction = 1432`

Moreover, the updated account.txt will be identical to its input (that is, pre-update) version.

### You can use the sample [`account-in.txt`](account-in.txt) for input as `account.txt`
### After running the AWK script check the updated `account.txt` with [`account-out.txt`](account-out.txt)
