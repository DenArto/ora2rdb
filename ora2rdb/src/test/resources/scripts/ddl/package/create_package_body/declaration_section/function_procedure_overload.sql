
CREATE OR REPLACE PACKAGE BODY PACKAGE_OVERLOAD IS

    PROCEDURE Out_Screen1(NM IN NUMBER);

	PROCEDURE Out_Screen(Var IN VARCHAR2);

	PROCEDURE Out_Screen(NM IN NUMBER);

    FUNCTION Add_One_Num1(NM IN NUMBER, BM IN NUMBER) RETURN NUMBER;

	FUNCTION Add_One_Num(NM IN NUMBER, BM IN NUMBER) RETURN NUMBER;

	FUNCTION Add_One_Num(M IN NUMBER, K IN VARCHAR2) RETURN VARCHAR;


    PROCEDURE Out_Screen(Var IN NUMBER) IS

    BEGIN
        g_last_output := 'String processed: ' || Var;
    END Out_Screen;

    PROCEDURE Out_Screen(Var IN VARCHAR2) IS

    BEGIN
        g_last_output := 'String processed: ' || Var;
    END Out_Screen;

    FUNCTION Add_One_Num(NM IN NUMBER, BM IN NUMBER) RETURN NUMBER IS
        v_result NUMBER;
    BEGIN
        v_result := NM + BM;
        RETURN v_result;
    END Add_One_Num;

    FUNCTION Add_One_Num(M IN NUMBER, K IN VARCHAR2) RETURN VARCHAR2 IS
        v_result VARCHAR2(4000);
    BEGIN
        v_result := TO_CHAR(M) || K;
        RETURN v_result;
    END Add_One_Num;

END PACKAGE_OVERLOAD;
