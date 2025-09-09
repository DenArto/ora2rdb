package ru.redsoft.ora2rdb;

import org.antlr.v4.runtime.*;

import java.util.ArrayList;
import java.util.List;

public class CustomErrorListener extends BaseErrorListener {
    private List<String> errorMessages = new ArrayList<>();

    @Override
    public void syntaxError(Recognizer<?, ?> recognizer, Object offendingSymbol, int line, int charPositionInLine, String msg, RecognitionException e) {
        String errorMessage = "Error at line " + line + ":" + charPositionInLine + " - " + msg;
        errorMessage = errorMessage.replaceAll("/\\*", "").replaceAll("\\*/", "");
        errorMessages.add(errorMessage);
    }

    public List<String> getErrorMessages() {
        return errorMessages;
    }
}
