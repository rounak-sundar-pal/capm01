using { rounak.db.master,rounak.db.transaction } from '../db/datamodel';

service CatalogService {

    entity AddressSet as projection on master.address;
    entity BusinesspartnerSet as projection on master.businesspartner; 
    entity Product as projection on master.product;
    @Capabilities:{Insertable,Updatable,Deletable,}
    entity Employee as projection on master.employees;
    entity POs @( title : '{i18n>poHeader}' )  as projection on transaction.purchaseorder{
        *,
        Items : redirected to POItems
    };

    entity POItems @( title : '{i18n>poItems}') as projection on transaction.poitems{
        *,
        PARENT_KEY: redirected to POs,
        PRODUCT_GUID : redirected to Product
    }

}
