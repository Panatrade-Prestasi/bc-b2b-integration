page 50094 "PP Ship-to Address API"
{
    APIGroup = 'pntpri';
    APIPublisher = 'panatradeprestasi';
    APIVersion = 'v2.0';
    Caption = 'ppShipToAddressAPI';
    DelayedInsert = true;
    EntityName = 'ppShiptoAddress';
    EntitySetName = 'ppShiptoAddresses';
    PageType = API;
    SourceTable = "Ship-to Address";
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(customerNo; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                    Editable = false;
                    NotBlank = true;
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                    NotBlank = true;
                }
                field(name2; Rec."Name 2")
                {
                    Caption = 'Name 2';
                }
                field(eMail; Rec."E-Mail")
                {
                    Caption = 'Email';
                    NotBlank = true;
                }
                field(address; Rec.Address)
                {
                    Caption = 'Address';
                    NotBlank = true;
                }
                field(address2; Rec."Address 2")
                {
                    Caption = 'Address 2';
                }
                field(city; Rec.City)
                {
                    Caption = 'City';
                    NotBlank = true;
                }
                field(county; Rec.County)
                {
                    Caption = 'County';
                    NotBlank = true;
                }
                field(countryRegionCode; Rec."Country/Region Code")
                {
                    Caption = 'Country/Region Code';
                    NotBlank = true;
                }
                field(postCode; Rec."Post Code")
                {
                    Caption = 'Post Code';
                    NotBlank = true;
                }
                field(phoneNo; Rec."Phone No.")
                {
                    Caption = 'Phone No.';
                    NotBlank = true;
                }
                field(primaryShipAddress; primaryShipAddress)
                {
                    Caption = 'Primary Ship-to Address';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
            }
        }
    }
    var
        primaryShipAddress: Boolean;
        lCustomerRec: Record Customer;

    trigger OnAfterGetRecord()
    begin
        Clear(lCustomerRec);
        lCustomerRec.Reset();
        if lCustomerRec.Get(Rec."Customer No.") then begin
            if lCustomerRec."Ship-to Code" = Rec.Code then begin
                primaryShipAddress := true;
            end
            else
                primaryShipAddress := false;
        end else
            Error('Cannot find customer %1', Rec."Customer No.");
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        lShiptoAddressRec: Record "Ship-to Address";
        lCode: Integer;
        lName: Text[100];
    begin
        // if Rec."Customer No." = '' then
        //     emptyErrorList.Add('customerNo');
        // // Error('Name cannot be empty');

        // if Rec.Name = '' then
        //     emptyErrorList.Add('name');
        // // Error('Name cannot be empty');

        // if Rec.Address = '' then
        //     emptyErrorList.Add('address');
        // // Error('Address cannot be empty');

        // if Rec."Country/Region Code" = '' then
        //     emptyErrorList.Add('countryRegionCode');
        // // Error('Country/Region Code cannot be empty');

        // if Rec.City = '' then
        //     emptyErrorList.Add('city');
        // // Error('City cannot be empty');

        // if Rec."Post Code" = '' then
        //     emptyErrorList.Add('postCode');
        // // Error('Post Code cannot be empty');

        // if Rec."Phone No." = '' then
        //     emptyErrorList.Add('phoneNo');
        // // Error('Phone No. cannot be empty');

        // if Rec."E-Mail" = '' then
        //     emptyErrorList.Add('eMail');
        // // Error('E-Mail cannot be empty');

        // // if Rec.Contact = '' then
        // //     emptyErrorList.Add('contactName');
        // // Error('Contact cannot be empty');

        // emptyErrorLength := emptyErrorList.Count();

        // if emptyErrorLength > 0 then begin
        //     if (emptyErrorLength - 1) > 0 then begin
        //         for index := 1 to (emptyErrorLength - 1) do begin
        //             emptyErrorTemp += (emptyErrorList.Get(index) + ', ');
        //         end;
        //     end
        //     else
        //         emptyErrorTemp += (emptyErrorList.Get(1) + ', ');

        //     emptyErrorTemp := emptyErrorTemp.Remove(StrLen(emptyErrorTemp) - 1, 2);

        //     if emptyErrorLength > 1 then begin
        //         emptyErrorTemp += (' and ' + emptyErrorList.Get(emptyErrorLength));
        //     end;
        //     Error(StrSubstNo(emptyErrorLabel, emptyErrorTemp));
        // end;

        lName := Rec.Name;

        Clear(lShiptoAddressRec);
        lShiptoAddressRec.Reset();
        lShiptoAddressRec.SetRange("Customer No.", Rec."Customer No.");
        if lShiptoAddressRec.FindLast() then begin
            Rec.Code := IncStr(lShiptoAddressRec.Code);
        end
        else begin
            Rec.Code := '001';
        end;

        Rec.Insert(true);

        Rec.Name := lName;

        Rec.Modify(true);

        if primaryShipAddress then begin
            Clear(lCustomerRec);
            lCustomerRec.Reset();
            if lCustomerRec.Get(Rec."Customer No.") then begin
                lCustomerRec."Ship-to Code" := Rec.Code;
                lCustomerRec.Modify(true);
            end
            else begin
                Error('Cannot find customer %1', Rec."Customer No.");
            end;
        end;


        exit(false);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        if primaryShipAddress then begin
            Clear(lCustomerRec);
            lCustomerRec.Reset();
            if lCustomerRec.Get(Rec."Customer No.") then begin
                lCustomerRec."Ship-to Code" := Rec.Code;
                lCustomerRec.Modify(true);
            end
            else begin
                Error('Cannot find customer %1', Rec."Customer No.");
            end;
        end;
    end;
}
