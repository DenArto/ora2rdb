

CREATE PROCEDURE Proc(Var  NUMERIC(34, 8))  SQL SECURITY DEFINER
 AS
    BEGIN
        g_last_output = 'String processed: ' || :Var;
    END ;


/*[-unconvertible RS-246918 CREATE PROCEDURE procedure_overload(Var  NUMERIC(34, 8))  SQL SECURITY DEFINER
 AS

    BEGIN
        g_last_output = 'String processed: ' || :Var;
    END ;]*/


/*[-unconvertible RS-246918 CREATE PROCEDURE procedure_overload(Var  VARCHAR)  SQL SECURITY DEFINER
 AS

    BEGIN
        g_last_output = 'String processed: ' || :Var;
    END ;]*/


CREATE FUNCTION func(NM  NUMERIC(34, 8), BM  NUMERIC(34, 8)) RETURNS NUMERIC(34, 8)  SQL SECURITY DEFINER
 AS
         DECLARE v_result VARCHAR(4000);
    BEGIN
        RETURN v_result;
    END ;


/*[-unconvertible RS-246918 CREATE FUNCTION function_overload(NM  NUMERIC(34, 8), BM  NUMERIC(34, 8)) RETURNS NUMERIC(34, 8)  SQL SECURITY DEFINER
 AS
         DECLARE v_result VARCHAR(4000);
    BEGIN
        RETURN v_result;
    END ;]*/


/*[-unconvertible RS-246918 CREATE FUNCTION function_overload(NM  NUMERIC(34, 8), BM  NUMERIC(34, 8)) RETURNS NUMERIC(34, 8)  SQL SECURITY DEFINER
 AS
         DECLARE v_result VARCHAR(4000);
    BEGIN
        RETURN v_result;
    END ;]*/





CREATE PROCEDURE Out_Screen(Var  NUMERIC(34, 8))  SQL SECURITY DEFINER
 AS
/*

            DECLARE PROCEDURE Out_Screen1(NM  NUMERIC(34, 8));

            [-unconvertible RS-246918 DECLARE PROCEDURE Out_Screen(Var  VARCHAR);]

            [-unconvertible RS-246918 DECLARE PROCEDURE Out_Screen(NM  NUMERIC(34, 8));]

            DECLARE FUNCTION Add_One_Num1(NM  NUMERIC(34, 8), BM  NUMERIC(34, 8)) RETURNS NUMERIC(34, 8);

            [-unconvertible RS-246918 DECLARE FUNCTION Add_One_Num(NM  NUMERIC(34, 8), BM  NUMERIC(34, 8)) RETURNS NUMERIC(34, 8);]

            [-unconvertible RS-246918 DECLARE FUNCTION Add_One_Num(M  NUMERIC(34, 8), K  VARCHAR) RETURNS VARCHAR(32765);]

            DECLARE PROCEDURE base1(Var  NUMERIC(34, 8)) AS

            BEGIN
                g_last_output = 'String processed: ' || :Var;
            END

            [-unconvertible RS-246918 DECLARE PROCEDURE base_p(Var  NUMERIC(34, 8)) AS

            BEGIN
                g_last_output = 'String processed: ' || :Var;
            END ]

            [-unconvertible RS-246918 DECLARE PROCEDURE base_p(Var  VARCHAR) AS

            BEGIN
                g_last_output = 'String processed: ' || :Var;
            END ]

            DECLARE FUNCTION base2(NM  NUMERIC(34, 8), BM  NUMERIC(34, 8)) RETURNS NUMERIC(34, 8) AS
                 DECLARE v_result VARCHAR(4000);
            BEGIN
                RETURN v_result;
            END

            [-unconvertible RS-246918 DECLARE FUNCTION base_f(NM  NUMERIC(34, 8), BM  NUMERIC(34, 8)) RETURNS NUMERIC(34, 8) AS
                 DECLARE v_result VARCHAR(4000);
            BEGIN
                RETURN v_result;
            END ]

            [-unconvertible RS-246918 DECLARE FUNCTION base_f(M  NUMERIC(34, 8), K  VARCHAR) RETURNS VARCHAR(32765) AS
                 DECLARE v_result VARCHAR(4000);
            BEGIN
                RETURN v_result;
            END ]
    */
BEGIN
/*

    */
END ;



CREATE FUNCTION Add_One_Num(NM  NUMERIC(34, 8), BM  NUMERIC(34, 8)) RETURNS NUMERIC(34, 8)  SQL SECURITY DEFINER
 AS
/*

            DECLARE PROCEDURE Out_Screen1(NM  NUMERIC(34, 8));

            [-unconvertible RS-246918 DECLARE PROCEDURE Out_Screen(Var  VARCHAR);]

            [-unconvertible RS-246918 DECLARE PROCEDURE Out_Screen(NM  NUMERIC(34, 8));]

            DECLARE FUNCTION Add_One_Num1(NM  NUMERIC(34, 8), BM  NUMERIC(34, 8)) RETURNS NUMERIC(34, 8);

            [-unconvertible RS-246918 DECLARE FUNCTION Add_One_Num(NM  NUMERIC(34, 8), BM  NUMERIC(34, 8)) RETURNS NUMERIC(34, 8);]

            [-unconvertible RS-246918 DECLARE FUNCTION Add_One_Num(M  NUMERIC(34, 8), K  VARCHAR) RETURNS VARCHAR(32765);]

            DECLARE PROCEDURE base1(Var  NUMERIC(34, 8)) AS

            BEGIN
                g_last_output = 'String processed: ' || :Var;
            END

            [-unconvertible RS-246918 DECLARE PROCEDURE base_p(Var  NUMERIC(34, 8)) AS

            BEGIN
                g_last_output = 'String processed: ' || :Var;
            END ]

            [-unconvertible RS-246918 DECLARE PROCEDURE base_p(Var  VARCHAR) AS

            BEGIN
                g_last_output = 'String processed: ' || :Var;
            END ]

            DECLARE FUNCTION base2(NM  NUMERIC(34, 8), BM  NUMERIC(34, 8)) RETURNS NUMERIC(34, 8) AS
                 DECLARE v_result VARCHAR(4000);
            BEGIN
                RETURN v_result;
            END

            [-unconvertible RS-246918 DECLARE FUNCTION base_f(NM  NUMERIC(34, 8), BM  NUMERIC(34, 8)) RETURNS NUMERIC(34, 8) AS
                 DECLARE v_result VARCHAR(4000);
            BEGIN
                RETURN v_result;
            END ]

            [-unconvertible RS-246918 DECLARE FUNCTION base_f(M  NUMERIC(34, 8), K  VARCHAR) RETURNS VARCHAR(32765) AS
                 DECLARE v_result VARCHAR(4000);
            BEGIN
                RETURN v_result;
            END ]

             DECLARE v_result VARCHAR(4000);

    */
BEGIN
/*
          RETURN v_result;
    */
END ;