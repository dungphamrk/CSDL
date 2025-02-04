-- Bảng Vendor
create database hello;

use hello;

CREATE TABLE Vendor (
    Ven_id CHAR(5) PRIMARY KEY,
    Ven_name VARCHAR(100) NOT NULL UNIQUE,
    Ven_address TEXT NOT NULL,
    Ven_phone CHAR(10) NOT NULL,
    Ven_email VARCHAR(100) NOT NULL,
    Ven_status BIT DEFAULT 1
);

-- Bảng Purchase_Order
CREATE TABLE Purchase_Order (
    PO_id INT AUTO_INCREMENT PRIMARY KEY,
    PO_order_date DATE NOT NULL,
    Ven_id CHAR(5) NOT NULL,
    PO_status TINYINT,
    FOREIGN KEY (Ven_id) REFERENCES Vendor(Ven_id)
);

-- Bảng Supplies
CREATE TABLE Supplies (
    Sup_id CHAR(5) PRIMARY KEY,
    Sup_name VARCHAR(100) NOT NULL UNIQUE,
    Sup_status BIT DEFAULT 1
);

-- Bảng Purchase_Order_Details
CREATE TABLE Purchase_Order_Details (
    Sup_id CHAR(5),
    PO_id INT,
    PRIMARY KEY (Sup_id, PO_id),
    FOREIGN KEY (Sup_id) REFERENCES Supplies(Sup_id),
    FOREIGN KEY (PO_id) REFERENCES Purchase_Order(PO_id)
);

-- Bảng Receipt_Note
CREATE TABLE Receipt_Note (
    RN_id CHAR(5) PRIMARY KEY,
    RN_import_date DATE NOT NULL,
    RN_created DATE NOT NULL,
    RN_total_amount FLOAT,
    RN_status TINYINT
);

-- Bảng Detailed_Receipt_Note
CREATE TABLE Detailed_Receipt_Note (
    RN_id CHAR(5),
    Sup_id CHAR(5),
    DRN_import_unit_price FLOAT CHECK (DRN_import_unit_price > 0),
    DRN_import_quantity INT NOT NULL,
    PRIMARY KEY (RN_id, Sup_id),
    FOREIGN KEY (RN_id) REFERENCES Receipt_Note(RN_id),
    FOREIGN KEY (Sup_id) REFERENCES Supplies(Sup_id)
);

-- Bảng Delivery_Note
CREATE TABLE Delivery_Note (
    DN_id CHAR(5) PRIMARY KEY,
    DN_export_date DATE NOT NULL,
    DN_created DATE NOT NULL,
    DN_total_amount FLOAT,
    DN_status TINYINT
);

-- Bảng Detailed_Delivery_Note
CREATE TABLE Detailed_Delivery_Note (
    DN_id CHAR(5),
    Sup_id CHAR(5),
    DDN_export_unit_price FLOAT CHECK (DDN_export_unit_price > 0),
    DDN_export_quantity INT NOT NULL,
    PRIMARY KEY (DN_id, Sup_id),
    FOREIGN KEY (DN_id) REFERENCES Delivery_Note(DN_id),
    FOREIGN KEY (Sup_id) REFERENCES Supplies(Sup_id)
);
