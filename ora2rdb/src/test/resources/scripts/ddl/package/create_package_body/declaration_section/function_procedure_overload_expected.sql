



/*RECREATE   PACKAGE BODY PACKAGE_OVERLOAD AS BEGIN

    PROCEDURE Out_Screen1(NM  NUMERIC(34, 8));

	[-unconvertible RS-246918 PROCEDURE Out_Screen(Var  VARCHAR);]

	[-unconvertible RS-246918 PROCEDURE Out_Screen(NM  NUMERIC(34, 8));]

    FUNCTION Add_One_Num1(NM  NUMERIC(34, 8), BM  NUMERIC(34, 8)) RETURNS NUMERIC(34, 8);

	[-unconvertible RS-246918 FUNCTION Add_One_Num(NM  NUMERIC(34, 8), BM  NUMERIC(34, 8)) RETURNS NUMERIC(34, 8);]

	[-unconvertible RS-246918 FUNCTION Add_One_Num(M  NUMERIC(34, 8), K  VARCHAR) RETURNS VARCHAR(32765);]


    [-unconvertible RS-246918 PROCEDURE Out_Screen(Var  NUMERIC(34, 8)) AS

    BEGIN
        g_last_output = 'String processed: ' || :Var;
    END ]

    [-unconvertible RS-246918 PROCEDURE Out_Screen(Var  VARCHAR) AS

    BEGIN
        g_last_output = 'String processed: ' || :Var;
    END ]

    [-unconvertible RS-246918 FUNCTION Add_One_Num(NM  NUMERIC(34, 8), BM  NUMERIC(34, 8)) RETURNS NUMERIC(34, 8) AS
         DECLARE v_result NUMERIC(34, 8);
    BEGIN
        v_result = :NM + :BM;
        RETURN v_result;
    END ]

    [-unconvertible RS-246918 FUNCTION Add_One_Num(M  NUMERIC(34, 8), K  VARCHAR) RETURNS VARCHAR(32765) AS
/*
         DECLARE v_result VARCHAR(4000);
    */
BEGIN
/*
        v_result = [-unconvertible RS-245838 CAST(:M)] || :K;
        RETURN v_result;
    */
END ]

  END ;*/