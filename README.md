# Gawky-printer
### This is another fun project to write a program using AWK to print and update your passbook (along with the interest accrued) and show the changes made.


Let's say we have a bank account in the Foopradesh Bank of Barland. Our account starts with an opening balance on
a date. After that, our account undergoes a sequence of transactions. The transactions are as follows.
### Debit transactions
You make ATM withdrawals, e-payments to merchants, and bank transfers to other accounts.
### Credit transactions
Your salary is deposited to your account on the first day of every month.
On December 31 of every year, the bank deposits (yearly) interest to your account. The interest rate
is constant (5% per annum). If your account balance is B for n consecutive days, the interest is
computed at the rate of 5% for n days. If your balance changes to B' because of a debit from or a
credit to your account, the interest will be calculated on the updated balance for as long as the
balance remains B'. However, the interest is not deposited to your account until the last day of the
year. The interest should be maintained as a floating-point value. While depositing, the bank converts
it to the nearest integer by rounding. After this, your yearly interest for the next year is reset to zero.
Notice that the per-day interest is slightly lower in a leap year than it is in a non-leap year.

We need to update our passbook from time to time. Your bank maintains your account details in a central
server. However, for passbook printing at your local branch, the local server does not contact the central
server. The local server instead keeps a copy of your transactions in a text file account.txt. This file is always
kept sorted in the increasing order of the transaction dates. Each line of the file is a record of five fields
separated by colons.

`Date:Credit Amount:Debit Amount:Balance:Type of transaction`

When you open your account, only the following line is added to account.txt:

`22-10-2019:::31201:ACCOUNT OPENED`

This line means that you open your account on Oct 22, 2019 with an opening balance of 31201. After that,
you make transactions to/from your account. These transactions are stored in the file account.txt without the
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

The gray entries do not have the balance field filled up. Morever, this file does not store the interest paid by
the bank on the last day of 2019 until you update your passbook. When you update your passbook, all the
missing balances are calculated, and the interest(s) deposited (if any) at the end of the year(s) is/are also
added. Therefore, if your update your passbook on January 20, 2020, the file account.txt updates as follows
(assume that there are no transactions after January 17, 2020). The new items added are highlighted in red.
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
the interest that you get in 2019, and adds a credit entry with the date 31-12-2019. The last line is not for
storing in the file account.txt. You may consider this as a user message shown to you on the display of the
passbook-printing machine.
Suppose that you make some other transactions after this passbook printing, and the file account.txt now
stores the following records.

