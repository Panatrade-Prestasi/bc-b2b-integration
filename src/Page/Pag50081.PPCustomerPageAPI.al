page 50081 "PP Customer Page API"
{
    APIGroup = 'pntpri';
    APIPublisher = 'panatradeprestasi';
    APIVersion = 'v2.0';
    Caption = 'ppCustomerPageAPI';
    DelayedInsert = true;
    EntityName = 'ppCustomer';
    EntitySetName = 'ppCustomers';
    PageType = API;
    SourceTable = Customer;
    ODataKeyFields = "No.";
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
                    Editable = false;
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
                field(mobilePhoneNo; Rec."Mobile Phone No.")
                {
                    Caption = 'Mobile Phone No.';
                    NotBlank = true;
                }
                field(contactName; contactName)
                {
                    Caption = 'Contact Name';
                    NotBlank = true;
                }
                field(shiptoCode; Rec."Ship-to Code")
                {
                    Caption = 'Ship-to Code';
                    NotBlank = true;
                }
                field(vatRegistrationNo; Rec."VAT Registration No.")
                {
                    Caption = 'VAT Registration No.';
                    NotBlank = true;
                }
                field(nik; Rec."Ibiz02 NIK")
                {
                    Caption = 'NIK';
                    NotBlank = true;
                }
                field(customerDiscGroup; Rec."Customer Disc. Group")
                {
                    Caption = 'Customer Disc. Group';
                    Editable = false;
                }
                field(blocked; Rec.Blocked)
                {
                    Caption = 'Blocked';
                    Editable = false;
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'System Id';
                    Editable = false;
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'System Modified At';
                    Editable = false;
                }
                part(shiptoAddresses; "PP Ship-to Address API")
                {
                    Multiplicity = Many;
                    Caption = 'Ship-to Addresses';
                    EntityName = 'ppShiptoAddress';
                    EntitySetName = 'ppShiptoAddresses';
                    SubPageLink = "Customer No." = Field("No.");
                }
            }
        }
    }

    var
        contactName: Text[100];

    trigger OnAfterGetRecord()
    begin
        contactName := Rec.Contact;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        noSeriesManagement: Codeunit NoSeriesManagement;
        salesReceivableSetup: Record "Sales & Receivables Setup";
    begin

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

        // if Rec."Mobile Phone No." = '' then
        //     emptyErrorList.Add('mobilePhoneNo');
        // // Error('Mobile Phone No. cannot be empty');

        // if Rec."E-Mail" = '' then
        //     emptyErrorList.Add('eMail');
        // // Error('E-Mail cannot be empty');

        // // if Rec.Contact = '' then
        // //     emptyErrorList.Add('contactName');
        // // Error('Contact cannot be empty');

        // if Rec."VAT Registration No." = '' then
        //     emptyErrorList.Add('vatRegistrationNo');
        // // Error('VAT Registration No. cannot be empty');

        // if Rec."Ibiz02 NIK" = '' then
        //     emptyErrorList.Add('nik');
        // // Error('NIK cannot be empty');
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

        Rec.Validate("Ship-to Code", '');

        if Rec."No." = '' then begin
            salesReceivableSetup.Get();
            salesReceivableSetup.TestField("Customer Nos.");
            Rec."No." := noSeriesManagement.GetNextNo(salesReceivableSetup."Customer Nos.", Today, true);
            Rec."No. Series" := salesReceivableSetup."Customer Nos.";
        end;

        Rec.Insert(true);

        Rec.Validate(Contact, contactName);

        Rec.Modify(true);

        exit(false);
    end;

    trigger OnModifyRecord(): Boolean
    var
        RMSetup: Record "Marketing Setup";
        UpdateContFromCust: Codeunit "CustCont-Update";
    begin
        if xRec.Contact <> contactName then begin
            if RMSetup.Get then begin
                if RMSetup."Bus. Rel. Code for Customers" <> '' then begin
                    Rec.Validate("Primary Contact No.", '');
                    Rec.Contact := contactName;
                    Rec.Modify;
                    UpdateContFromCust.OnModify(Rec);
                    UpdateContFromCust.InsertNewContactPerson(Rec, false);

                end
                else
                    Error('Bus. Rel. Code for Customers in Marketing Setup table is empty.');
            end
            else
                Error('Cannot fetch Marketing Setup table data is empty.');
        end;

        Rec.Modify(true);

        exit(false);
    end;
}