//
//  AccountVariants.swift
//  ABL
//
//  Created by Hamza Amin on 4/28/22.
//

import Foundation

enum AccountVariant: Double {
    
    case currentAccount = 108201
    case alliedEasyCurrentAccount = 108204
    case alliedSeniorCitizenAccount = 108206
    case alliedYouthAccount18To25 = 108208
    case alliedYouthAccount26To35 = 108209
    case plsSavingAccount = 108210
    case alliedAsaanAccountSaving = 108215
    case khanumAsaanAccount = 108216
    case alliedIslamicCurrentAccount = 108218
    case alliedIslamicSavingAccount = 108222
    case alliedIslamicSahulatAccount = 108225
    case alliedIslamicAsaanSavingAccount = 108226
    case alliedAitbarSeniorCitizenAccount = 108228
    case alliedIslamicYouthAccount18To25 = 108230
    case alliedIslamicYouthAccount26To35 = 108231
    case fcCurrNewAccount = 108234
    case isbCurrFCY = 108235
    case fcSBNewAccount = 108236
    case isbSavingsFCY = 108237
    case khanumCurrentAccount = 108240
    case khanumSavingAccount = 108241
    case seniorCitizenSavingAccount = 108242
    case asaanDigitalAccount = 108243
    case asaanDigitalRemittanceAccount = 108244
    case freelancerDigitalAccount = 108245
    case freelancerDigitalAccountFCY = 108246
    case alliedIslamicAsaanDigitalAccount = 108247
    case alliedAitebarAsaanDigitalRemittanceAccountRC = 108248
    case freelancerDigitalAccountIslamic = 108249
    case alliedAitebarFreelancerDigitalAccountC = 108250
    case unknown = 0
    
    var id: Double {
        switch self {
        case .asaanDigitalAccount:
            return 108243
        case .freelancerDigitalAccount:
            return 108245
        case .asaanDigitalRemittanceAccount:
            return 108244
        case .currentAccount:
            return 108201
        case .alliedEasyCurrentAccount:
            return 108204
        case .alliedSeniorCitizenAccount:
            return 108206
        case .alliedYouthAccount18To25:
            return 108208
        case .alliedYouthAccount26To35:
            return 108209
        case .plsSavingAccount:
            return 108210
        case .alliedAsaanAccountSaving:
            return 108215
        case .khanumAsaanAccount:
            return 108216
        case .alliedIslamicCurrentAccount:
            return 108218
        case .alliedIslamicSavingAccount:
            return 108222
        case .alliedIslamicSahulatAccount:
            return 108225
        case .alliedIslamicAsaanSavingAccount:
            return 108226
        case .alliedAitbarSeniorCitizenAccount:
            return 108228
        case .alliedIslamicYouthAccount18To25:
            return 108230
        case .alliedIslamicYouthAccount26To35:
            return 108231
        case .fcCurrNewAccount:
            return 108234
        case .isbCurrFCY:
            return 108235
        case .fcSBNewAccount:
            return 108236
        case .isbSavingsFCY:
            return 108237
        case .khanumCurrentAccount:
            return 108240
        case .khanumSavingAccount:
            return 108241
        case .seniorCitizenSavingAccount:
            return 108242
        case .freelancerDigitalAccountFCY:
            return 108246
        case .alliedIslamicAsaanDigitalAccount:
            return 108247
        case .alliedAitebarAsaanDigitalRemittanceAccountRC:
            return 108248
        case .freelancerDigitalAccountIslamic:
            return 108249
        case .alliedAitebarFreelancerDigitalAccountC:
            return 108250
        case .unknown:
            return 0
        }
    }
    
    var currency: Currency {
        switch self {
        case .asaanDigitalAccount:
            return .PKR
        case .freelancerDigitalAccount:
            return .PKR
        case .asaanDigitalRemittanceAccount:
            return .PKR
        case .currentAccount:
            return .PKR
        case .alliedEasyCurrentAccount:
            return .PKR
        case .alliedSeniorCitizenAccount:
            return .PKR
        case .alliedYouthAccount18To25:
            return .PKR
        case .alliedYouthAccount26To35:
            return .PKR
        case .plsSavingAccount:
            return .PKR
        case .alliedAsaanAccountSaving:
            return .PKR
        case .khanumAsaanAccount:
            return .PKR
        case .alliedIslamicCurrentAccount:
            return .PKR
        case .alliedIslamicSavingAccount:
            return .PKR
        case .alliedIslamicSahulatAccount:
            return .PKR
        case .alliedIslamicAsaanSavingAccount:
            return .PKR
        case .alliedAitbarSeniorCitizenAccount:
            return .PKR
        case .alliedIslamicYouthAccount18To25:
            return .PKR
        case .alliedIslamicYouthAccount26To35:
            return .PKR
        case .fcCurrNewAccount:
            return .All
        case .isbCurrFCY:
            return .All
        case .fcSBNewAccount:
            return .All
        case .isbSavingsFCY:
            return .All
        case .khanumCurrentAccount:
            return .PKR
        case .khanumSavingAccount:
            return .PKR
        case .seniorCitizenSavingAccount:
            return .PKR
        case .freelancerDigitalAccountFCY:
            return .USD
        case .alliedIslamicAsaanDigitalAccount:
            return .PKR
        case .alliedAitebarAsaanDigitalRemittanceAccountRC:
            return .PKR
        case .freelancerDigitalAccountIslamic:
            return .PKR
        case .alliedAitebarFreelancerDigitalAccountC:
            return .USD
        case .unknown:
            return .PKR
        }
    }
    
    var description: String {
        switch self {
        case .asaanDigitalAccount:
            return """
Debit Card: UPI paypak cobadged Asaan Debit Card
Cheque Book: On customer request and charges are Rs. 12 per leaf
 Limits:
• Maximum credit balance limit of PKR 1,000,000;
• Monthly debit limit of PKR 1,000,000;
• Cash Withdrawal Limit Upto available Balance
This account is only for low-profile customers with limited financial requirements/ needs and not available for Politically Exposed Persons/ High Net Worth customers.
"""
        case .freelancerDigitalAccount:
            return """
Debit Card: UPI paypak cobadged Asaan Debit Card
Cheque Book: On customer request and charges are Rs. 12 per leaf
Limits:
i Currency: PKR/ FCY
ii Monthly limit of USD 5,000 or equivalent (debit & credit limits shall be applied separately);
iii Cash withdrawal limit of PKR 500,000/- or equivalent per day;
This account is only for low-profile customers with limited financial requirements/ needs and not available for Politically Exposed Persons/ High Net Worth customers.
"""
        case .asaanDigitalRemittanceAccount:
            return """
Debit Card: UPI paypak cobadged Asaan Debit Card
Cheque Book: On customer request and charges are Rs. 12 per leaf
 Limits:
Maximum credit balance limit of PKR 3,000,000;
iii Cash withdrawal limit of PKR 500,000 per day;
• Cash Withdrawal Limit Upto available Balance
This account is only for low-profile customers with limited financial requirements/ needs and not available for Politically Exposed Persons/ High Net Worth customers.
"""
        case .currentAccount:
            return """
Allied Bank Current Account offers a host of free services on maintaining a monthly average balance of Rs.250,000/- & above.
Free Online Cash Deposit and Withdrawal
Free Online Clearing collection by Remote Branch
Free Online Balance Enquiry
Free Online Printing of Statement of account
Free Manual Remittances for Account to Account transfer only & Issuance of DD/TT/PO/ABC/OBC/ Express Collection/Call Deposit Receipt by debit to the Account only from parent branch only
Issuance of Debit card as per SOC
Free Access to myABL Internet Banking
Fees: Monthly Service Charges: 50/-only if monthly average balance falls below Rs. 25,000/-
"""
        case .alliedEasyCurrentAccount:
            return """
No Service charges on Minimum Balance Requirement
Issuance of Debit Card
Free access to myABL Internet Banking
"""
        case .alliedSeniorCitizenAccount:
            return """
Current account for senior citizens of 55 years or above
2 free online transactions per month
Free myABL internet banking access
Free medical health card
Offering up to 30% discounts at labs (Unlimited) Check the list of available labs
Accidental death/disability insurance coverage up to Rs.500,000 (Upto age 69 yrs.)
Hospitalization coverage of up to Rs.6,000 per day (Upto age 65 yrs.)
Pay Anyone (send cash to any CNIC holder even without any account)
No monthly fee on maintaining average balance of Rs.50,000* ( A fee for Additional Services Rs. 140/- will be charged in case of non maintenance)ok
"""
        case .alliedYouthAccount18To25:
            return """
Branded Youth Debit Card
Free first cheque book of 10 leaves
2 free online transactions per month
Corporate Internship Opportunity
Free myABL Internet Banking access
Free premium access to Vouch365 application offering buy one get one exciting offers for restaurants, beauty salons, health & fitness, leisure/travel activities
Free accidental insurance coverage up to Rs.500,000
Pay Anyone (send cash to any CNIC holder even without any account)
No monthly fee on maintaining average balance of Rs.50,000* for customers aged 26-35 and Rs.10,000* for customers aged 18-25 (A fee for Additional Services Rs. 50/- will be charged in case of non maintenance.)
"""
        case .alliedYouthAccount26To35:
            return """
Current account for individuals aged 26 to 35 years of age
Branded Youth Debit Card
Free first cheque book of 10 leaves
2 free online transactions per month
Corporate Internship Opportunity
Free myABL Internet Banking access
Free premium access to Vouch365 application offering buy one get one exciting offers for restaurants, beauty salons, health & fitness, leisure/travel activities
Free accidental insurance coverage up to Rs.500,000
Pay Anyone (send cash to any CNIC holder even without any account)
No monthly fee on maintaining average balance of Rs.50,000* for customers aged 26-35 and Rs.10,000* for customers aged 18-25 (A fee for Additional Services Rs. 50/- will be charged in case of non maintenance.)
"""
        case .plsSavingAccount:
            return """
Allied Bank PLS Savings Account offers following free services in the following month on maintaining average balance of Rs. 2.5 Million in a month
Free Issuance of DD/TT/PO/Allied Banker’s Cheque
Exemption of Service Charges on Salary Accounts of institutions under special arrangement with Allied Bank
No joining fee for the issuance of Allied Cash+Shop Visa Debit Card
Access to myABL Internet Banking on Personal Computer and Mobile
"""
        case .alliedAsaanAccountSaving:
            return """
Monthly profit on PLS Saving Rate
Easy account opening process only on provision of ID Document
No minimum balance requirement
No account maintenance/service charges
Allied UPI & PayPak Debit Card
FREE issuance of first Cheque Book of 10 leaves
"""
        case .khanumAsaanAccount:
            return ""
        case .alliedIslamicCurrentAccount:
            return """
The Bank will utilize all such deposits as the Bank may deem appropriate in approved Shariah compliant modes of financing / investments.
No charges will be recovered at the time of closing the account.
Initial deposit amount: Rupees 1,000 for Pak Rupees Accounts and 100 units in respective foreign currency.
AML/KYC/CDD/FATCA requirements will be as per SBP instructions and guidelines issued by the bank from time to time.
Initial deposit requirement will be relaxed (as per SBP’s instructions) for the followings categories:,1. Mustahkeen of Zakat,2. Students,3. Employees of Government or Semi Government institutions for salary and pension purposes (including widows / children of deceased employees eligible for family pension / benevolent fund grant etc.),other autonomous bodies and similar types of accounts.
No restriction on transaction amount and number of deposit / withdrawal transactions (except otherwise stated).
Free or against charges (at parent / remote branch), value added services may be offered to account holder(s) at the discretion of the Bank. However the Bank reserves the right to offer such services based on the criteria approved by the Bank from time to time and may also be specified in the Schedule of Bank Charges.
Cheque Book will be issued to the customer for withdrawal of funds.
Eligible for following as per the Bank’s discretion:,1. Online banking services (Cash Deposit, Cash Withdrawal and Funds Transfer) available at the Bank’s entire network.,2. Globally accepted Allied Cash Plus Shop Visa Debit Card / ATM Card/PayPak Debit Card.,3. Access to myABL Internet Banking.,4. Pay Anyone facility and issuance/payment of ABC/CDR,5. 24/7 access to account through Allied Phone Banking.,6. SMS Alert service on transactions.,7. Facility of remittance in Local or Foreign Currency through respective type of account(s) shall be available as per SBP regulations and Bank’s Policy.
Account will be opened as per the process mentioned in Banking Services Manual.
"""
        case .alliedIslamicSavingAccount:
            return """
Saving Accounts will be operated based on the mode of Mudaraba with No Minimum balance requirement.
Profits or Loss will be shared on monthly/six monthly basis or as may be decided / declared from time to time at the discretion of the Bank.
No charges will be recovered at the time of closing the account.
AML/KYC/CDD/FATCA requirements will be as per SBP instructions and guidelines issued by the bank from time to time.
The Bank will utilize all such deposits as the Bank may deem appropriate in approved Shariah compliant modes of financing / investments.
Free or against charges (at parent / remote branch), value added services may be offered to account holder(s) at the discretion of the Bank. However the Bank reserves the right to offer such services based on the criteria approved by the Bank from time to time and may also be specified in the Schedule of Bank Charges.
Cheque Book will be issued to the customer for withdrawal of funds
No restriction on transaction amount and number of deposit / withdrawal transactions (except otherwise stated).
Eligible for following as per the Bank’s discretion:, Online banking services (Cash Deposit, Cash Withdrawal and Funds Transfer) available at the Bank’s entire network.
Globally accepted Allied Cash Plus Shop Visa Debit Card / ATM Card/PayPak Debit Card.
Access to myABL Internet Banking.
Pay Anyone facility and issuance/payment of ABC/CDR
24/7 access to account through Allied Phone Banking.
SMS Alert service on transactions.
Facility of remittance in Local or Foreign Currency through respective type of account(s) shall be available as per SBP regulations and Bank’s Policy.
"""
        case .alliedIslamicSahulatAccount:
            return """
1. The Bank will utilize all such deposits as the Bank may deem appropriate in Shariah compliant modes of financing / investments.
2. No charges will be recovered at the time of closing the account.
3. Initial deposit amount: Rupees 1,000 for Pak Rupees Accounts.
4. No initial deposit will be required for the followings categories:, Mustahkeen of Zakat, Students, Employees of Government or Semi Government institutions for salary and pension purposes (including widows / children of deceased employees eligible for family pension / benevolent fund grant etc.), other autonomous bodies and similar types of accounts.
5. No restriction on number of deposit / withdrawal transactions (except otherwise stated).
6. Free or against charges (at parent / remote branch), value added services may be offered to account holder(s) at the discretion of the Bank. However the Bank reserves the right to offer such services based on the criteria approved by the Bank from time to time and specified in the Schedule of Bank Charges.
7. Eligible for following as per the Bank’s discretion:
Online banking services (Cash Deposit, Cash Withdrawal and Funds Transfer) available at the Bank’s entire network.
Globally accepted Allied Cash plus Shop Visa Debit Card / ATM Card.
Access to myABL Internet Banking.
24/7 access to account through Allied Phone Banking.
SMS Alert service on transactions.
Facility of foreign remittances through the Local currency accounts, to the extent of amount allowed by State Bank of Pakistan only for certain categories such as for student’s fee, medical charges, travel expense etc.
Account will be operated based on the mode of Mudaraba (profit/loss sharing basis).
The Account can be opened singly/jointly.
Initial deposit amount: Rupees 1,000 for Pak Rupees Accounts.
Profits or Loss will be shared on six monthly basis or as may be decided / declared from time to time at the discretion of the Bank.
Account can only be opened in Pak Rupees only.
There are different minimum balance requirements (subject to change by the Bank from time to time) with reference to the Locker size as mentioned in below table. The Account Holder will be allowed one free of charge Safe Deposit Locker accordingly after marking lien on the amount equivalent to minimum balance.
Safe Deposit Lockers Minimum Balance*, Small Rs. 40,000/-
"""
        case .alliedIslamicAsaanSavingAccount:
            return """
Simplified account opening.
Initial deposit requirement for account opening is Rupees 100.
Account can only be opened in Pak Rupees only.
Transaction turnover (Debit & Credit each) Rs. 500,000/- per month.
The Accounts will be operated based on the mode of Mudaraba with no Minimum balance requirement for profit calculation.
Profit calculation on average balance of the month and payment on half yearly basis.
No account maintenance/conversion/closing charges
Complimentary statement of account on half yearly basis.
Free first cheque book of 10 leaves.
Issuance of Allied PayPak Debit Card.
"""
        case .alliedAitbarSeniorCitizenAccount:
            return """
Initial Deposit for Account opening is Rs. 1,000/- for Regular Account and Rs. 100/- for Asaan Account variant
Profit calculated on monthly Average Balance and paid monthly
Free Accidental Death & Disability Takaful coverage up to Rs. 500,000/-*
Free In-Hospitalization benefit coverage of 6,000/- per day*
Free Medical Health Card – providing up to 30% discounts on Lab Services*
Free Two (02) Intercity online transactions per month (Cash Deposit/Withdrawal or Account to Account Transfer)
Free E-Statements
Free Access to myABL Internet Banking
Balance requirement Rs. 50,000/- per month*
* Terms & Conditions apply
"""
        case .alliedIslamicYouthAccount18To25:
            return """
Initial Deposit for Account opening is Rs. 1,000/- for Regular Account and Rs. 100/- for Asaan Account variant
Profit calculated on monthly Average Balance and paid monthly
Free Accidental Death & Disability Takaful coverage up to Rs. 500,000/- *
Free Premium access to Vouch 365 Mobile Application*
Free First PayPak Debit Card (for Asaan account variant)
Free First Cheque Book (10 Leaves)
Free Two (02) Intercity online transactions per month (Cash Deposit/Withdrawal or Account to Account Transfer)
Free Access to myABL Internet Banking
Free E-Statements
Corporate Internship Opportunity
Balance requirement Rs. 10,000/- per month for customers aged 18-25 years and Rs. 50,000/- per month for customers aged 26-35 years*
* Terms & Conditions apply"
"""
        case .alliedIslamicYouthAccount26To35:
            return """
Initial Deposit for Account opening is Rs. 1,000/- for Regular Account and Rs. 100/- for Asaan Account variant
Profit calculated on monthly Average Balance and paid monthly
Free Accidental Death & Disability Takaful coverage up to Rs. 500,000/- *
Free Premium access to Vouch 365 Mobile Application*
Free First PayPak Debit Card (for Asaan account variant)
Free First Cheque Book (10 Leaves)
Free Two (02) Intercity online transactions per month (Cash Deposit/Withdrawal or Account to Account Transfer)
Free Access to myABL Internet Banking
Free E-Statements
Corporate Internship Opportunity
Balance requirement Rs. 10,000/- per month for customers aged 18-25 years and Rs. 50,000/- per month for customers aged 26-35 years*
* Terms & Conditions apply
"""
            
        case .fcCurrNewAccount:
            return """
Debit Card:   VISA Classic Debit Card (USD Only)
VISA Platinum Debit Card (USD Only)
VISA Premium Debit Card (USD) Only
Issuance as per SOC
Cheque Book:
Issuance as per SOC ( USD $ 5 per cheque book of 25 leaf or equivalent)
"""
        case .isbCurrFCY:
            return """
1. Individuals (singly/Jointly) and business entities (subject SBP formalities) can open this account
2. Cheque book issuance as per IBG SOC
3. Debit Card of any following variant as per customer’s choice upon meeting the eligibility criteria  will be available
•VISA Classic Debit Card (USD only)
•VISA Platinum Debit Card (USD only)
•VISA Premium Debit Card (USD only)
"""
        case .fcSBNewAccount:
            return """
Debit Card:   VISA Classic Debit Card (USD Only)
VISA Platinum Debit Card (USD Only)
VISA Premium Debit Card (USD) Only
Issuance as per SOC
Cheque Book:
Issuance as per SOC ( USD $ 5 per cheque book of 25 leaf or equivalent)
"""
        case .isbSavingsFCY:
            return """
1. Individuals (singly/Jointly) and business entities (subject SBP formalities) can open this account
2. Cheque book issuance as per IBG SOC
3.  Debit Card of any following variant as per customer’s choice upon meeting the eligibility criteria  will be available
•VISA Classic Debit Card (USD only)
•VISA Platinum Debit Card (USD only)
•VISA Premium Debit Card (USD only)
"""
        case .khanumCurrentAccount:
            return """
Debit Card: UPI Paypak Cobadged Classic Plus Debit Card only
Cheque Book:  Issuance on customer requested and charges are Rs. 12 per leaf
Locker Rent: 50% discount on 1st year locker rent for new issuance only
Discounted Markup Rate: 1% discounted markup rate on consumer financing
"""
        case .khanumSavingAccount:
            return """
"Debit Card: UPI Paypak Cobadged Classic Plus Debit Card only
Cheque Book:  Issuance on customer requested and charges are Rs. 15 per leaf
Locker Rent: 50% discount on 1st year locker rent for new issuance only
Discounted Markup Rate: 1% discounted markup rate on consumer financing
"""
        case .seniorCitizenSavingAccount:
            return """
Debit Card: Free issuance of UPI paypka Classic Debit Card. Other variants charges as per SOC
Cheque Book:  Issuance on customer requested and charges are Rs. 15 per leaf
Insurance Coverage: The accidental death coverage is Rs. 300,000
Hospitalization Coverage: The hospitalization coverage is Rs. 1000 per day
"""
        case .freelancerDigitalAccountFCY:
            return """
1. Only natural persons and Resident Pakistani Individuals can open this account
2. Cheque book issuance as per SOC
3. Debit Card: Visa Classic Debit Card-FCY(USD)
4. Limits:
• Monthly limit of USD 5,000 or equivalent (debit & credit limits shall be applied separately).
• Cash Withdrawal Limit of PKR 500,000/- or equivalent per day.This account is only for low-profile customers with limited financial requirements/ needs and not available for Politically Exposed Persons/ High Net Worth customers."
"""
        case .alliedIslamicAsaanDigitalAccount:
            return """
1. Cheque book issuance as per IBG SOC
2. Debit Card: UPI Paypak Asaan
3. Limits:
• Maximum credit balance limit of PKR 1,000,000;
• Monthly debit limit of PKR 1,000,000;
• Cash Withdrawal Limit Upto available Balance
This account is only for low-profile customers with limited financial requirements/ needs and not available for Politically Exposed Persons/ High Net Worth customers.
"""
        case .alliedAitebarAsaanDigitalRemittanceAccountRC:
            return """
2. Cheque book issuance as per IBG SOC
3. Debit Card: UPI Paypak Asaan
4. Limits:
• Maximum credit balance limit of PKR 3,000,000
• Fund transfer limit of PKR 500,000 per day
• Account may also be fed through local credit to the extent of PKR 1,000,000 per month
• No commercial remittances shall be allowed.
• Cash Withdrawal Limit of PKR 500,000 per day
This account is only for low-profile customers with limited financial requirements/ needs and not available for Politically Exposed Persons/ High Net Worth customers.
"""
        case .freelancerDigitalAccountIslamic:
            return """
2. Cheque book issuance as per IBG SOC
3. Debit Card: UPI Paypak Classic or other variants of customer’s choice upon meeting the eligibility criteria
4. Limits:
• Monthly limit of USD 5,000 or equivalent (debit & credit limits shall be applied separately).
• Cash Withdrawal Limit of PKR 500,000/- or equivalent per day
This account is only for low-profile customers with limited financial requirements/ needs and not available for Politically Exposed Persons/ High Net Worth customers.
"""
        case .alliedAitebarFreelancerDigitalAccountC:
            return """
1. Only natural persons and Resident Pakistani Individuals can open this account
2. Cheque book issuance as per SOC
3. Debit Card: Visa Classic Debit Card-FCY(USD)
4. Limits:
• Monthly limit of USD 5,000 or equivalent (debit & credit limits shall be applied separately).
• Cash Withdrawal Limit of PKR 500,000/- or equivalent per day.This account is only for low-profile customers with limited financial requirements/ needs and not available for Politically Exposed Persons/ High Net Worth customers.
"""
        case .unknown:
            return ""
        }
    }
    
    static func filter(by proofOfIncome: ProofOfIncome) -> [AccountVariant] {
        switch proofOfIncome {
        case .yes:
            return [
                AccountVariant.currentAccount,
                AccountVariant.alliedEasyCurrentAccount,
                AccountVariant.alliedSeniorCitizenAccount,
                AccountVariant.alliedYouthAccount18To25,
                AccountVariant.alliedYouthAccount26To35,
                AccountVariant.plsSavingAccount,
                AccountVariant.alliedIslamicCurrentAccount,
                AccountVariant.alliedIslamicSavingAccount,
                AccountVariant.alliedIslamicSahulatAccount,
                AccountVariant.alliedAitbarSeniorCitizenAccount,
                AccountVariant.alliedIslamicYouthAccount18To25,
                AccountVariant.alliedIslamicYouthAccount26To35,
                AccountVariant.fcCurrNewAccount,
                AccountVariant.isbCurrFCY,
                AccountVariant.fcSBNewAccount,
                AccountVariant.isbSavingsFCY,
                AccountVariant.khanumCurrentAccount,
                AccountVariant.khanumSavingAccount,
                AccountVariant.seniorCitizenSavingAccount,
            ]
        case .no:
            return [
                AccountVariant.alliedAsaanAccountSaving,
                AccountVariant.alliedIslamicAsaanSavingAccount,
                AccountVariant.asaanDigitalAccount,
                AccountVariant.asaanDigitalRemittanceAccount,
                AccountVariant.freelancerDigitalAccount,
                AccountVariant.freelancerDigitalAccountFCY,
                AccountVariant.alliedIslamicAsaanDigitalAccount,
                AccountVariant.alliedAitebarAsaanDigitalRemittanceAccountRC,
                AccountVariant.freelancerDigitalAccountIslamic,
                AccountVariant.alliedAitebarFreelancerDigitalAccountC
            ]
        }
    }
    
}
