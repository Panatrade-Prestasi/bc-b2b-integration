page 50091 "PP Item Page API"
{
    APIGroup = 'pntpri';
    APIPublisher = 'panatradeprestasi';
    APIVersion = 'v2.0';
    Caption = 'ppItemsPageAPI';
    DelayedInsert = true;
    EntityName = 'ppItem';
    EntitySetName = 'ppItems';
    PageType = API;
    SourceTable = Item;
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
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(description2; Rec."Description 2")
                {
                    Caption = 'Description 2';
                }
                field(itemDiscGroup; Rec."Item Disc. Group")
                {
                    Caption = 'Item Disc. Group';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'System Modified At';
                }
                part(itemVariants; "PP Item Variant Page API")
                {
                    Multiplicity = Many;
                    Caption = 'Item Variants';
                    EntityName = 'ppItemVariant';
                    EntitySetName = 'ppItemVariants';
                    SubPageLink = "Item No." = Field("No.");
                }
            }
        }
    }
}
