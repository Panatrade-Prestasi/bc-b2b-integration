page 50093 "PP Item Disc. Group Page API"
{
    APIGroup = 'pntpri';
    APIPublisher = 'panatradeprestasi';
    APIVersion = 'v2.0';
    Caption = 'ppItemDiscGroupPageAPI';
    DelayedInsert = true;
    EntityName = 'ppItemDiscGroup';
    EntitySetName = 'ppItemDiscGroups';
    PageType = API;
    SourceTable = "Item Discount Group";
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
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }

                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'System Modified At';
                }
                part(ppSalesLineDisc; "PP Sales Line Disc. Page API")
                {
                    Multiplicity = Many;
                    Caption = 'Items';
                    EntityName = 'ppSalesLineDiscount';
                    EntitySetName = 'ppSalesLineDiscounts';
                    SubPageLink = "Code" = Field("Code");
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
