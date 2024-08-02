@SuppressWarnings('PMD.CyclomaticComplexity, PMD.CognitiveComplexity')
public with sharing class Lists {
    /**
     * @description Checks if the list of objects is empty
     * @param values list of objects
     * @return either true or false
     */
    public static Boolean isEmpty(List<Object> values) {
        if (values == null) {
            return true;
        }

        return values.isEmpty();
    }

    /**
     * @description Checks if the incoming list of objects is not empty
     */
    public static Boolean isNotEmpty(List<Object> values) {
        return !isEmpty(values);
    }

    public static Object getFieldValues(List<SObject> records, SObjectField field) {
        DescribeFieldResult fieldDescribe = field.getDescribe();
        return getFieldValues(
            records,
            fieldDescribe.getName(),
            Type.forName(String.valueOf(fieldDescribe.getSoapType()))
        );
    }

    /**
     * @description This method retrieves the values of a specified field from a list of SObjects.
     *
     * @param records The list of SObjects from which to retrieve the field values.
     * @param fieldName The API name of the field whose values need to be retrieved.
     * @param fieldValueType - Field type
     * @return A list of field values
     */
    public static Object getFieldValues(
        List<SObject> records,
        String fieldName,
        Type fieldValueType
    ) {
        GenericList fieldValues = newList(fieldValueType);

        if (Lists.isEmpty(records) || String.isBlank(fieldName)) {
            return fieldValues.toList();
        }

        for (SObject record : records) {
            if (record.get(fieldName) == null) {
                continue;
            }
            fieldValues.add(record.get(fieldName));
        }

        return fieldValues.toList();
    }

    private interface GenericList {
        Object toList();
        void add(Object value);
    }

    private static GenericList newList(Type valueType) {
        Object genericList = Type.forName('List<' + valueType + '>').newInstance();

        if (valueType == Id.class) {
            return new ListIds((List<Id>) genericList);
        }
        if (valueType == String.class) {
            return new ListStrings((List<String>) genericList);
        }
        if (valueType == Integer.class) {
            return new ListIntegers((List<Integer>) genericList);
        }
        if (valueType == Decimal.class || valueType == Double.class) {
            return new ListDecimals((List<Decimal>) genericList);
        }
        if (valueType == Date.class) {
            return new ListDates((List<Date>) genericList);
        }
        if (valueType == Datetime.class) {
            return new ListDateTimes((List<Datetime>) genericList);
        }
        if (valueType == Boolean.class) {
            return new ListBooleans((List<Boolean>) genericList);
        }
        if (valueType == Time.class) {
            return new ListTimes((List<Time>) genericList);
        }

        return new ListStrings((List<String>) genericList);
    }

    private class ListIds implements GenericList {
        private final List<Id> listInstance;

        public ListIds(List<Id> listInstance) {
            this.listInstance = listInstance;
        }
        public void add(Object value) {
            listInstance.add((Id) value);
        }

        public Object toList() {
            return listInstance;
        }
    }

    private class ListStrings implements GenericList {
        private final List<String> listInstance;

        public ListStrings(List<String> listInstance) {
            this.listInstance = listInstance;
        }
        public void add(Object value) {
            listInstance.add((String) value);
        }

        public Object toList() {
            return listInstance;
        }
    }

    private class ListIntegers implements GenericList {
        private final List<Integer> listInstance;

        public ListIntegers(List<Integer> listInstance) {
            this.listInstance = listInstance;
        }
        public void add(Object value) {
            listInstance.add((Integer) value);
        }

        public Object toList() {
            return listInstance;
        }
    }

    private class ListDecimals implements GenericList {
        private final List<Decimal> listInstance;

        public ListDecimals(List<Decimal> listInstance) {
            this.listInstance = listInstance;
        }
        public void add(Object value) {
            listInstance.add((Decimal) value);
        }

        public Object toList() {
            return listInstance;
        }
    }

    private class ListDates implements GenericList {
        private final List<Date> listInstance;

        public ListDates(List<Date> listInstance) {
            this.listInstance = listInstance;
        }
        public void add(Object value) {
            listInstance.add((Date) value);
        }

        public Object toList() {
            return listInstance;
        }
    }

    private class ListDateTimes implements GenericList {
        private final List<Datetime> listInstance;

        public ListDateTimes(List<Datetime> listInstance) {
            this.listInstance = listInstance;
        }
        public void add(Object value) {
            listInstance.add((Datetime) value);
        }

        public Object toList() {
            return listInstance;
        }
    }

    private class ListBooleans implements GenericList {
        private final List<Boolean> listInstance;

        public ListBooleans(List<Boolean> listInstance) {
            this.listInstance = listInstance;
        }
        public void add(Object value) {
            listInstance.add((Boolean) value);
        }

        public Object toList() {
            return listInstance;
        }
    }

    private class ListTimes implements GenericList {
        private final List<Time> listInstance;

        public ListTimes(List<Time> listInstance) {
            this.listInstance = listInstance;
        }
        public void add(Object value) {
            listInstance.add((Time) value);
        }

        public Object toList() {
            return listInstance;
        }
    }
}