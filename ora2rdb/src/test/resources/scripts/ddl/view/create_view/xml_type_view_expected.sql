/* This type of view is not supported */
/*CREATE VIEW warehouse_view [-unconvertible RS-241929 OF XMLTYPE
        XMLSCHEMA "http://www.example.com/xwarehouses.xsd"
        ELEMENT "Warehouse"
        WITH OBJECT ID
        (extract(OBJECT_VALUE, '/Warehouse/Area/text()').getnumberval())]
AS SELECT [-unconvertible RS-244710 XMLELEMENT("Warehouse",
                     XMLFOREST(WarehouseID as "Building",
                               area as "Area",
                               docks as "Docks",
                               docktype as "DockType",
                               wateraccess as "WaterAccess",
                               railaccess as "RailAccess",
                               parking as "Parking",
                               VClearance as "VClearance"))]
   FROM warehouse_table;*/