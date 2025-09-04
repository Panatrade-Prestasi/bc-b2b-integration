page 50090 "PP Sales Line Disc. Page API"
{
    APIGroup = 'pntpri';
    APIPublisher = 'panatradeprestasi';
    APIVersion = 'v2.0';
    Caption = 'ppSalesLineDiscPageAPI';
    DelayedInsert = true;
    EntityName = 'ppSalesLineDiscount';
    EntitySetName = 'ppSalesLineDiscounts';
    PageType = API;
    SourceTable = "Sales Line Discount";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(salesType; Rec."Sales Type")
                {
                    Caption = 'Sales Type';
                }
                field(salesCode; Rec."Sales Code")
                {
                    Caption = 'Sales Code';
                }
                field("type"; Rec."Type")
                {
                    Caption = 'Type';
                }
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(lineDiscount; Rec."Line Discount %")
                {
                    Caption = 'Line Discount %';
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }
                field(startingDate; Rec."Starting Date")
                {
                    Caption = 'Starting Date';
                }
                field(minimumQuantity; Rec."Minimum Quantity")
                {
                    Caption = 'Minimum Quantity';
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code';
                }
                field(variantCode; Rec."Variant Code")
                {
                    Caption = 'Variant Code';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'System Modified At';
                }
                part(items; "PP Item Page API")
                {
                    Multiplicity = Many;
                    Caption = 'Items';
                    EntityName = 'ppItem';
                    EntitySetName = 'ppItems';
                    SubPageLink = "Item Disc. Group" = Field("Code");
                }
            }
        }
    }
}
