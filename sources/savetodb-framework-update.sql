ALTER SESSION SET "_ORACLE_SCRIPT"=true;

SELECT CASE WHEN 1008 <= CAST(CAST(SUBSTR(HANDLER_CODE, 1, INSTR(HANDLER_CODE, '.') - 1) AS VARCHAR2(10)) AS NUMBER) * 100 + CAST(CAST(SUBSTR(HANDLER_CODE, INSTR(HANDLER_CODE, '.') + 1) AS VARCHAR2(10)) AS NUMBER) THEN 'SaveToDB Framework is up-to-date. Update skipped' ELSE '' END AS CHECK_VERSION FROM XLS.HANDLERS WHERE TABLE_SCHEMA = 'XLS' AND TABLE_NAME = 'SAVETODB_FRAMEWORK' AND COLUMN_NAME = 'VERSION' AND EVENT_NAME = 'Information';

MERGE INTO XLS.HANDLERS t
USING
    (
    SELECT
        CAST(NULL AS VARCHAR2(30)) AS TABLE_SCHEMA
        , CAST(NULL AS VARCHAR2(30)) AS TABLE_NAME
        , CAST(NULL AS VARCHAR2(30)) AS COLUMN_NAME
        , CAST(NULL AS VARCHAR2(30)) AS EVENT_NAME
        , CAST(NULL AS VARCHAR2(30)) AS HANDLER_SCHEMA
        , CAST(NULL AS VARCHAR2(256)) AS HANDLER_NAME
        , CAST(NULL AS VARCHAR2(30)) AS HANDLER_TYPE
        , CAST(NULL AS VARCHAR2(2000)) HANDLER_CODE
        , CAST(NULL AS VARCHAR2(256)) AS TARGET_WORKSHEET
        , CAST(NULL AS NUMBER) AS MENU_ORDER
        , CAST(NULL AS NUMBER) AS EDIT_PARAMETERS
    FROM DUAL

    UNION ALL SELECT 'XLS', 'SAVETODB_FRAMEWORK', 'VERSION', 'Information', NULL, NULL, 'ATTRIBUTE', '10.8', NULL, NULL, NULL FROM DUAL
    UNION ALL SELECT 'XLS', 'HANDLERS', 'EVENT_NAME', 'ValidationList', NULL, NULL, 'VALUES', 'Actions, AddHyperlinks, AddStateColumn, Authentication, BitColumn, Change, ContextMenu, ConvertFormulas, DataTypeBit, DataTypeBoolean, DataTypeDate, DataTypeDateTime, DataTypeDateTimeOffset, DataTypeDouble, DataTypeInt, DataTypeGuid, DataTypeString, DataTypeTime, DataTypeTimeSpan, DefaultListObject, DefaultValue, DependsOn, DoNotAddChangeHandler, DoNotAddDependsOn, DoNotAddManyToMany, DoNotAddValidation, DoNotChange, DoNotConvertFormulas, DoNotKeepComments, DoNotKeepFormulas, DoNotSave, DoNotSelect, DoNotSort, DoNotTranslate, DoubleClick, DynamicColumns, Format, Formula, FormulaValue, Information, JsonForm, KeepFormulas, KeepComments, License, LoadFormat, ManyToMany, ParameterValues, ProtectRows, RegEx, SaveFormat, SaveWithoutTransaction, SelectionChange, SelectionList, SelectPeriod, SyncParameter, UpdateChangedCellsOnly, UpdateEntireRow, ValidationList', NULL, NULL, NULL FROM DUAL

    ) s
    ON  (
    s.TABLE_NAME IS NOT NULL
    AND t.TABLE_SCHEMA = s.TABLE_SCHEMA
    AND t.TABLE_NAME = s.TABLE_NAME
    AND (t.COLUMN_NAME = s.COLUMN_NAME OR t.COLUMN_NAME IS NULL AND s.COLUMN_NAME IS NULL)
    AND t.EVENT_NAME = s.EVENT_NAME
    AND (t.HANDLER_SCHEMA = s.HANDLER_SCHEMA OR t.HANDLER_SCHEMA IS NULL AND s.HANDLER_SCHEMA IS NULL)
    AND (t.HANDLER_NAME = s.HANDLER_NAME OR t.HANDLER_NAME IS NULL AND s.HANDLER_NAME IS NULL)
    AND (t.HANDLER_TYPE = s.HANDLER_TYPE OR t.HANDLER_TYPE IS NULL AND s.HANDLER_TYPE IS NULL)
    AND (
    NOT (CAST(t.HANDLER_CODE AS VARCHAR2(2000)) = s.HANDLER_CODE OR t.HANDLER_CODE IS NULL AND s.HANDLER_CODE IS NULL)
    OR NOT (t.TARGET_WORKSHEET = s.TARGET_WORKSHEET OR t.TARGET_WORKSHEET IS NULL AND s.TARGET_WORKSHEET IS NULL)
    OR NOT (t.MENU_ORDER = s.MENU_ORDER OR t.MENU_ORDER IS NULL OR s.MENU_ORDER IS NULL)
    OR NOT (t.EDIT_PARAMETERS = s.EDIT_PARAMETERS OR t.EDIT_PARAMETERS IS NULL AND s.EDIT_PARAMETERS IS NULL)
    ))
WHEN MATCHED THEN
UPDATE SET
    t.HANDLER_CODE = s.HANDLER_CODE
    , t.TARGET_WORKSHEET = s.TARGET_WORKSHEET
    , t.MENU_ORDER = s.MENU_ORDER
    , t.EDIT_PARAMETERS = s.EDIT_PARAMETERS

INSERT INTO XLS.HANDLERS
    ( TABLE_SCHEMA
    , TABLE_NAME
    , COLUMN_NAME
    , EVENT_NAME
    , HANDLER_SCHEMA
    , HANDLER_NAME
    , HANDLER_TYPE
    , HANDLER_CODE
    , TARGET_WORKSHEET
    , MENU_ORDER
    , EDIT_PARAMETERS
    )
SELECT
    s.TABLE_SCHEMA
    , s.TABLE_NAME
    , s.COLUMN_NAME
    , s.EVENT_NAME
    , s.HANDLER_SCHEMA
    , s.HANDLER_NAME
    , s.HANDLER_TYPE
    , s.HANDLER_CODE
    , s.TARGET_WORKSHEET
    , s.MENU_ORDER
    , s.EDIT_PARAMETERS
    , t.*
FROM
    (
    SELECT
        CAST(NULL AS VARCHAR2(30)) AS TABLE_SCHEMA
        , CAST(NULL AS VARCHAR2(30)) AS TABLE_NAME
        , CAST(NULL AS VARCHAR2(30)) AS COLUMN_NAME
        , CAST(NULL AS VARCHAR2(30)) AS EVENT_NAME
        , CAST(NULL AS VARCHAR2(30)) AS HANDLER_SCHEMA
        , CAST(NULL AS VARCHAR2(256)) AS HANDLER_NAME
        , CAST(NULL AS VARCHAR2(30)) AS HANDLER_TYPE
        , CAST(NULL AS VARCHAR2(2000)) HANDLER_CODE
        , CAST(NULL AS VARCHAR2(256)) AS TARGET_WORKSHEET
        , CAST(NULL AS NUMBER) AS MENU_ORDER
        , CAST(NULL AS NUMBER) AS EDIT_PARAMETERS
    FROM DUAL

    UNION ALL SELECT 'XLS', 'SAVETODB_FRAMEWORK', 'VERSION', 'Information', NULL, NULL, 'ATTRIBUTE', '10.8', NULL, NULL, NULL FROM DUAL
    UNION ALL SELECT 'XLS', 'HANDLERS', 'EVENT_NAME', 'ValidationList', NULL, NULL, 'VALUES', 'Actions, AddHyperlinks, AddStateColumn, Authentication, BitColumn, Change, ContextMenu, ConvertFormulas, DataTypeBit, DataTypeBoolean, DataTypeDate, DataTypeDateTime, DataTypeDateTimeOffset, DataTypeDouble, DataTypeInt, DataTypeGuid, DataTypeString, DataTypeTime, DataTypeTimeSpan, DefaultListObject, DefaultValue, DependsOn, DoNotAddChangeHandler, DoNotAddDependsOn, DoNotAddManyToMany, DoNotAddValidation, DoNotChange, DoNotConvertFormulas, DoNotKeepComments, DoNotKeepFormulas, DoNotSave, DoNotSelect, DoNotSort, DoNotTranslate, DoubleClick, DynamicColumns, Format, Formula, FormulaValue, Information, JsonForm, KeepFormulas, KeepComments, License, LoadFormat, ManyToMany, ParameterValues, ProtectRows, RegEx, SaveFormat, SaveWithoutTransaction, SelectionChange, SelectionList, SelectPeriod, SyncParameter, UpdateChangedCellsOnly, UpdateEntireRow, ValidationList', NULL, NULL, NULL FROM DUAL

    ) s
    LEFT OUTER JOIN XLS.HANDLERS t ON
        t.TABLE_SCHEMA = s.TABLE_SCHEMA
        AND t.TABLE_NAME = s.TABLE_NAME
        AND (t.COLUMN_NAME = s.COLUMN_NAME OR t.COLUMN_NAME IS NULL AND s.COLUMN_NAME IS NULL)
        AND t.EVENT_NAME = s.EVENT_NAME
        AND (t.HANDLER_SCHEMA = s.HANDLER_SCHEMA OR t.HANDLER_SCHEMA IS NULL AND s.HANDLER_SCHEMA IS NULL)
        AND (t.HANDLER_NAME = s.HANDLER_NAME OR t.HANDLER_NAME IS NULL AND s.HANDLER_NAME IS NULL)
        AND (t.HANDLER_TYPE = s.HANDLER_TYPE OR t.HANDLER_TYPE IS NULL AND s.HANDLER_TYPE IS NULL)
WHERE
    t.TABLE_NAME IS NULL
    AND s.TABLE_NAME IS NOT NULL;

prompt SaveToDB Framework updated
