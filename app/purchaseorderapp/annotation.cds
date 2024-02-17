using { CatalogService } from '../../srv/CatalogService';

annotate CatalogService.POs  with{
    PARTNER_GUID@(
        Common:{
            Text : PARTNER_GUID.COMPANY_NAME
        },
        ValueList.entity : CatalogService.BusinesspartnerSet
    )
} ;

@cds.odata.valuelist
annotate CatalogService.BusinesspartnerSet with @(
    UI.Identification:[
        {
            $Type : 'UI.DataField',
            Value : COMPANY_NAME,
        },
    ]
) ;

annotate CatalogService.POItems  with{
    PRODUCT_GUID@(
        Common:{
            Text : PRODUCT_GUID.DESCRIPTION
        },
        ValueList.entity : CatalogService.BusinesspartnerSet
    )
} ;

@cds.odata.valuelist
annotate CatalogService.Product with @(
    UI.Identification:[
        {
            $Type : 'UI.DataField',
            Value : DESCRIPTION,
        },
    ] 
) ;



annotate CatalogService.POs with @(
    UI : {
        SelectionFields : [
            PO_ID,
            GROSS_AMOUNT,
            LIFECYCLE_STATUS,
            CURRENCY_code,

        ],
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : PO_ID,
            },
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataFieldForAction',
                Label : '{i18n>Boost}',
                Action : 'CatalogService.boost',
                Inline : true

            },
            {
                $Type : 'UI.DataField',
                Value : PARTNER_GUID.COMPANY_NAME,
            },
            {
                $Type : 'UI.DataField',
                Value : PARTNER_GUID.ADDRESS_GUID.COUNTRY,
            },
            {
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : LIFECYCLE_STATUS,
                Criticality : Criticality,
                CriticalityRepresentation : #WithIcon
            },
        ],
        HeaderInfo  : {
            $Type : 'UI.HeaderInfoType',
            TypeName : '{i18n>PurchaseOrder}',
            TypeNamePlural : '{i18n>PurchaseOrders}',
            Title:{
                Label : '{i18n>POID}',
                Value : PO_ID
            },
            Description:{
                Label : '{i18n>desc}',
                Value : PARTNER_GUID.COMPANY_NAME
            },
            ImageUrl : 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fcap.cloud.sap%2F&psig=AOvVaw2Dn3STkDhbaz3Li_ZhcClq&ust=1707937675866000&source=images&cd=vfe&opi=89978449&ved=0CBMQjRxqFwoTCKi5yuWBqYQDFQAAAAAdAAAAABAE'
        },
        Facets  : [{
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>PoGeneralInformation}',
            Target: ![@UI.FieldGroup#HeaderGeneralInformation]
        },{
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>PoItems}',
            Target : 'Items/@UI.LineItem'
        }
            
        ],
        FieldGroup#HeaderGeneralInformation  : {
            $Type : 'UI.FieldGroupType',
            Data : [
                {
                    $Type : 'UI.DataField',
                    Value : PO_ID,
                },
                {
                    $Type : 'UI.DataField',
                    Value : PARTNER_GUID_NODE_KEY,
                },
                {
                    $Type : 'UI.DataField',
                    Value : PARTNER_GUID.COMPANY_NAME,
                },
                {
                    $Type : 'UI.DataField',
                    Value : PARTNER_GUID.BP_ID,
                },
                {
                    $Type : 'UI.DataField',
                    Value : GROSS_AMOUNT,
                },
                {
                    $Type : 'UI.DataField',
                    Value : NET_AMOUNT,
                },
                {
                    $Type : 'UI.DataField',
                    Value : TAX_AMOUNT,
                },
                {
                    $Type : 'UI.DataField',
                    Value : CURRENCY_code,
                },
                {
                    $Type : 'UI.DataField',
                    Value : LIFECYCLE_STATUS,
                },
            ]
        },
    }

 ) ;

 annotate CatalogService.POItems with @(
    UI:{
        LineItem : [
            {
                $Type : 'UI.DataField',
                Value : PO_ITEM_POS,
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID_NODE_KEY,
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.PRODUCT_ID,
            },
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : CURRENCY_code,
            },
        ],
        HeaderInfo  : {
            $Type : 'UI.HeaderInfoType',
            TypeName : '{i18n>PoItem}',
            TypeNamePlural : '{i18n>PoItems}',
            Title: {
                $Type : 'UI.DataField',
                Value : PARENT_KEY.PO_ID
            },
            Description : {
                $Type : 'UI.DataField',
                Value : PO_ITEM_POS,
            },
        },
        Facets  : [{
            Label : '{i18n>LineItemHeader}',
            $Type : 'UI.ReferenceFacet',
            Target: ![@UI.FieldGroup#LineItemHeader]
        },
        {
            Label : '{i18n>ProductDetails}',
            $Type : 'UI.ReferenceFacet',
            Target : 'PRODUCT_GUID/@UI.FieldGroup#ProductDetails',
        },
            
        ],
        FieldGroup#LineItemHeader  : {
            $Type : 'UI.FieldGroupType',
            Data : [
                {
                    $Type : 'UI.DataField',
                    Value : PO_ITEM_POS,
                },
                {
                    $Type : 'UI.DataField',
                    Value : PRODUCT_GUID.NODE_KEY,
                },
                {
                    $Type : 'UI.DataField',
                    Value : GROSS_AMOUNT,
                },
                {
                    $Type : 'UI.DataField',
                    Value : TAX_AMOUNT,
                },
                {
                    $Type : 'UI.DataField',
                    Value : NET_AMOUNT,
                },
                {
                    $Type : 'UI.DataField',
                    Value : CURRENCY_code,
                },
            ],
        },
    }
  ) ;

  annotate CatalogService.Product with @(
    UI : {
        FieldGroup#ProductDetails  : {
            $Type : 'UI.FieldGroupType',
            Data:[
                {
                    $Type : 'UI.DataField',
                    Value : PRODUCT_ID,
                },
                {
                    $Type : 'UI.DataField',
                    Value : DESCRIPTION,
                },
                {
                    $Type : 'UI.DataField',
                    Value : TYPE_CODE,
                },
                {
                    $Type : 'UI.DataField',
                    Value : CATEGORY,
                },
                {
                    $Type : 'UI.DataField',
                    Value : SUPPLIER_GUID.COMPANY_NAME,
                },

            ]
        },
    }
  ) ;
  
 
