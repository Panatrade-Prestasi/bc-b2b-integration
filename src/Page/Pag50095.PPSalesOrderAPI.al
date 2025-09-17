page 50095 "PP SalesOrder API"
{
    APIGroup = 'jubelio';
    APIPublisher = 'panatrade';
    APIVersion = 'v2.0';
    Caption = 'ppSalesOrderAPI';
    DelayedInsert = true;
    EntityName = 'ppSalesOrder';
    EntitySetName = 'ppSalesOrders';
    PageType = API;
    SourceTable = "Jubelio Stagging Table";
    SourceTableView = where("Document Type" = const(1), "Entry Type" = const("Sales Order"), "Bound Action" = const(Inbound), Level = const(Header), "Table Type" = const(Stagging));
    //SourceTableTemporary = true;
    //ODataKeyFields = SystemId;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(orderId; Rec."Order Id")
                {
                }
                field(orderNo; Rec."Order No.")
                {
                }
                field(customerCode; Rec."Customer Code")
                {
                    Caption = 'Customer Code';
                }
                field(orderDate; Rec."Order Date")
                {
                    Caption = 'Order Date';
                }
                field(orderTime; Rec."Order Time")
                {
                    Caption = 'Order Time';
                }
                field(dueDate; Rec."Due Date")
                {
                    Caption = 'Due Date';
                }
                field(customerName; Rec."Customer Name")
                {
                    Caption = 'Sell-to Customer Name';
                }
                field(address; Rec.Address)
                {
                    Caption = 'Sell-to Address';
                }
                field(address2; Rec."Address 2")
                {
                    Caption = 'Sell-to Address 2';
                }
                field(city; Rec.City)
                {
                    Caption = 'Sell-to City';
                }
                field(postCode; Rec."Post Code")
                {
                    Caption = 'Sell-to Post Code';
                }
                field(phoneNo; Rec."Phone No.")
                {
                    Caption = 'Sell-to Phone No.';
                }
                field(eMail; Rec.Email)
                {
                    Caption = 'Email';
                }
                field(deliveryPriority; Rec."New Delivery Priority")
                {
                    Caption = 'Delivery Priority';
                }
                field(jenisPengiriman; Rec."Jenis Pengiriman")
                {
                    Caption = 'Jenis Pengiriman';
                }
                field(paymentMethod; Rec."Payment Method")
                {
                    Caption = 'Payment Method';
                }
                part(salesOrderLines; "Sales Order Subform API")
                {
                    EntitySetName = 'lines';
                    EntityName = 'lines';
                    //SubPageLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SalesDocType := SalesDocType::Order;
        Rec."Document Type" := SalesDocType.AsInteger();
        Rec."Entry Type" := Rec."Entry Type"::"Sales Order";
        Rec."Bound Action" := Rec."Bound Action"::Inbound;
        Rec."Entry No." := JblMgt.GetNextStaggingEntryNo();
        Rec.Level := Rec.Level::Header;
        Rec."Table Type" := Rec."Table Type"::Stagging;
        Rec."Date Time" := CurrentDateTime;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if JblMgt.CheckStaggingExist(Rec) then
            Error('Order No. %1 is exist', Rec."Order No.");
        CurrPage.salesOrderLines.Page.SetHeader(Rec);
    end;

    trigger OnAfterGetRecord()
    begin
        Clear(JblMgt);
        JblMgt.GenerateSalesOrder(Rec);
        if JblMgt.CheckErrorExist(Rec) then begin
            Rec."Status Order" := Rec."Status Order"::"Need Action";
            Rec.Modify();
        end else begin
            Rec."Status Order" := Rec."Status Order"::Processed;
            Rec.Modify();
        end;
        SalesHeader.get(SalesHeader."Document Type"::Order, Rec."Document No.");
        SalesHeader."Status Order" := Rec."Status Order";
        SalesHeader.Modify();
        exit;
        //JblMgt.WriteErrorMessage(Rec, GetLastErrorText());
    end;


    var
        SalesDocType: Enum "Sales Document Type";
        JblMgt: Codeunit "Jubelio Management";
        SalesHeader: Record "Sales Header";
}
