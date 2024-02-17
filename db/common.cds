namespace rounak.common;

using { Currency } from '@sap/cds/common';

type Gender  : String(1) enum {
    male         = 'M';
    female       = 'F';
    noDisclosure = 'D';
    nonBinary    = 'N';
    selfDescribe = 'S';
}


type AmountT : Decimal(15, 2) @(
    Semantics.amount.currencyCode: 'CURRENCY_CODE',
    sap.unit                     : 'CURRENCY_CODE'
);


abstract entity Amount {
    CURRENCY: Currency;	
    GROSS_AMOUNT:AmountT;	
    NET_AMOUNT:AmountT;
    TAX_AMOUNT:AmountT;
}

type phoneNumber : String(30)@assert.format : '^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$';
type Email : String(255)@assert.format : '^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$';