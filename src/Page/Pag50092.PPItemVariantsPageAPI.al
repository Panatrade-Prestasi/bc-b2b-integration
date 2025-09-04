page 50092 "PP Item Variant Page API"
{
    APIGroup = 'pntpri';
    APIPublisher = 'panatradeprestasi';
    APIVersion = 'v2.0';
    Caption = 'ppItemVariantsPageAPI';
    DelayedInsert = true;
    EntityName = 'ppItemVariant';
    EntitySetName = 'ppItemVariants';
    PageType = API;
    SourceTable = "Item Variant";
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
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(description2; Rec."Description 2")
                {
                    Caption = 'Description 2';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'System Modified At';
                }
            }
        }
    }
}
