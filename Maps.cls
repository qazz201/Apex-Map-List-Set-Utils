public with sharing class Maps {
    /**
     * Check if incoming map of objects by ids is null or empty
     */
    public static Boolean isEmpty(Map<Id, Object> objectsByIds) {
        return objectsByIds == null || objectsByIds.size() == 0;
    }

    public static Boolean isEmpty(Map<String, Object> objectByKeys) {
        return objectByKeys == null || objectByKeys.size() == 0;
    }

    public static Boolean isEmpty(Map<Double, Object> objectByKeys) {
        return objectByKeys == null || objectByKeys.size() == 0;
    }

    /**
     * Check if incoming map of objects by ids is not null or empty
     */
    public static Boolean isNotEmpty(Map<Id, Object> objectsByIds) {
        return !isEmpty(objectsByIds);
    }

    public static Boolean isNotEmpty(Map<String, Object> objectByKeys) {
        return !isEmpty(objectByKeys);
    }

    public static Boolean isNotEmpty(Map<Double, Object> objectByKeys) {
        return !isEmpty(objectByKeys);
    }

    /** @description groups records by value of incoming field
     * @param records - the collection for grouping
     * @param field - the name of the field to get a map key value from record
     * @return Map<K, List<SObject>>, K - field value type. Map of records grouped by field values which getting from the records
     */
    public static Object groupBy(List<SObject> records, SObjectField field) {
        DescribeFieldResult fieldDescribe = field.getDescribe();

        return groupBy(
            records,
            fieldDescribe.getName(),
            Type.forName(String.valueOf(fieldDescribe.getSoapType()))
        );
    }

    public static Object groupBy(List<SObject> records, String keyField, Type keyFieldType) {
        GenericMap groupMap = newMap(keyFieldType);

        List<Object> values = (List<Object>) new List<SObject>();

        for (SObject record : records) {
            Object key = record.get(keyField);

            if (!groupMap.containsKey(key)) {
                groupMap.put(key, values.clone());
            }

            ((List<Object>) groupMap.get(key)).add(record);
        }
        return groupMap.toMap();
    }

    /**
     * Map is not covariant types and there's no Map interface in Salesforce which would allow casting
     * differently typed Maps on abstract Map type.
     * Because of that, we cannot cast Map<Id, Account> to Map<Object,Object> or any other map
     * (unless we serialize and deserialize via JSON). It means, that we cannot have one generic method which would take
     * generic Map and operate on it, we would need separate methods for each type of key.
     * This wrapper is a workaround for this, it lets us use AbstractMap regardless of it's key type.
     * Instead of having separate methods for each kind of map, we have GenericMaps implementations for all primitive key types.
     */
    private interface GenericMap {
        Object toMap();
        Object keySet();
        void put(Object key, Object value);
        Object get(Object key);
        Boolean containsKey(Object key);
    }

    private static GenericMap newMap(Type keyType) {
        Object genericMap = Type.forName('Map<' + keyType + ',' + 'List<SObject>' + '>')
            .newInstance();

        if (keyType == Id.class) {
            return new MapById((Map<Id, Object>) genericMap);
        }
        if (keyType == String.class) {
            return new MapByString((Map<String, Object>) genericMap);
        }
        if (keyType == Integer.class) {
            return new MapByInteger((Map<Integer, Object>) genericMap);
        }
        if (keyType == Decimal.class ) {
            return new MapByDecimal((Map<Decimal, Object>) genericMap);
        }
        if ( keyType == Double.class  ) {
            return new MapByDouble((Map<Double, Object>) genericMap);
        }
        if (keyType == Date.class) {
            return new MapByDate((Map<Date, Object>) genericMap);
        }
        if (keyType == Datetime.class) {
            return new MapByDatetime((Map<Datetime, Object>) genericMap);
        }
        if (keyType == Boolean.class) {
            return new MapByBoolean((Map<Boolean, Object>) genericMap);
        }
        if (keyType == Time.class) {
            return new MapByTime((Map<Time, Object>) genericMap);
        }

        return new MapByObject((Map<Object, Object>) genericMap);
    }

    private class MapByObject implements GenericMap {
        private Map<Object, Object> mapInstance;

        public MapByObject(Map<Object, Object> mapInstance) {
            this.mapInstance = mapInstance;
        }
        public void put(Object key, Object value) {
            mapInstance.put(key, (List<SObject>) value);
        }
        public Boolean containsKey(Object key) {
            return mapInstance.containsKey(key);
        }
        public Object get(Object key) {
            return mapInstance.get(key);
        }
        public Object toMap() {
            return mapInstance;
        }
        public Object keySet() {
            return mapInstance.keySet().clone();
        }
    }

    private class MapById implements GenericMap {
        private Map<Id, Object> mapInstance;

        public MapById(Map<Id, Object> mapInstance) {
            this.mapInstance = mapInstance;
        }
        public void put(Object key, Object value) {
            mapInstance.put((Id) key, (List<SObject>) value);
        }
        public Boolean containsKey(Object key) {
            return mapInstance.containsKey((Id) key);
        }
        public Object get(Object key) {
            return mapInstance.get((Id) key);
        }
        public Object toMap() {
            return mapInstance;
        }
        public Object keySet() {
            return mapInstance.keySet().clone();
        }
    }

    private class MapByString implements GenericMap {
        private Map<String, Object> mapInstance;

        public MapByString(Map<String, Object> mapInstance) {
            this.mapInstance = mapInstance;
        }
        public void put(Object key, Object value) {
            mapInstance.put((String) key, (List<SObject>) value);
        }
        public Boolean containsKey(Object key) {
            return mapInstance.containsKey((String) key);
        }
        public Object get(Object key) {
            return mapInstance.get((String) key);
        }
        public Object toMap() {
            return mapInstance;
        }
        public Object keySet() {
            return mapInstance.keySet().clone();
        }
    }

    private class MapByInteger implements GenericMap {
        private Map<Integer, Object> mapInstance;

        public MapByInteger(Map<Integer, Object> mapInstance) {
            this.mapInstance = mapInstance;
        }
        public void put(Object key, Object value) {
            mapInstance.put((Integer) key, (List<SObject>) value);
        }
        public Boolean containsKey(Object key) {
            return mapInstance.containsKey((Integer) key);
        }
        public Object get(Object key) {
            return mapInstance.get((Integer) key);
        }
        public Object toMap() {
            return mapInstance;
        }
        public Object keySet() {
            return mapInstance.keySet().clone();
        }
    }

    private class MapByDecimal implements GenericMap {
        private Map<Decimal, Object> mapInstance;

        public MapByDecimal(Map<Decimal, Object> mapInstance) {
            this.mapInstance = mapInstance;
        }
        public void put(Object key, Object value) {
            mapInstance.put((Decimal) key, (List<SObject>) value);
        }
        public Boolean containsKey(Object key) {
            return mapInstance.containsKey((Decimal) key);
        }
        public Object get(Object key) {
            return mapInstance.get((Decimal) key);
        }
        public Object toMap() {
            return mapInstance;
        }
        public Object keySet() {
            return mapInstance.keySet().clone();
        }
    }

    private class MapByDouble implements GenericMap {
        private Map<Double, Object> mapInstance;

        public MapByDouble(Map<Double, Object> mapInstance) {
            this.mapInstance = mapInstance;
        }
        public void put(Object key, Object value) {
            mapInstance.put((Double) key, (List<SObject>) value);
        }
        public Boolean containsKey(Object key) {
            return mapInstance.containsKey((Double) key);
        }
        public Object get(Object key) {
            return mapInstance.get((Double) key);
        }
        public Object toMap() {
            return mapInstance;
        }
        public Object keySet() {
            return mapInstance.keySet().clone();
        }
    }

    private class MapByDate implements GenericMap {
        private Map<Date, Object> mapInstance;

        public MapByDate(Map<Date, Object> mapInstance) {
            this.mapInstance = mapInstance;
        }
        public void put(Object key, Object value) {
            mapInstance.put((Date) key, (List<SObject>) value);
        }
        public Boolean containsKey(Object key) {
            return mapInstance.containsKey((Date) key);
        }
        public Object get(Object key) {
            return mapInstance.get((Date) key);
        }
        public Object toMap() {
            return mapInstance;
        }
        public Object keySet() {
            return mapInstance.keySet().clone();
        }
    }

    private class MapByDatetime implements GenericMap {
        private Map<Datetime, Object> mapInstance;

        public MapByDatetime(Map<Datetime, Object> mapInstance) {
            this.mapInstance = mapInstance;
        }
        public void put(Object key, Object value) {
            mapInstance.put((Datetime) key, (List<SObject>) value);
        }
        public Boolean containsKey(Object key) {
            return mapInstance.containsKey((Datetime) key);
        }
        public Object get(Object key) {
            return mapInstance.get((Datetime) key);
        }
        public Object toMap() {
            return mapInstance;
        }
        public Object keySet() {
            return mapInstance.keySet().clone();
        }
    }

    private class MapByBoolean implements GenericMap {
        private Map<Boolean, Object> mapInstance;

        public MapByBoolean(Map<Boolean, Object> mapInstance) {
            this.mapInstance = mapInstance;
        }
        public void put(Object key, Object value) {
            mapInstance.put((Boolean) key, (List<SObject>) value);
        }
        public Boolean containsKey(Object key) {
            return mapInstance.containsKey((Boolean) key);
        }
        public Object get(Object key) {
            return mapInstance.get((Boolean) key);
        }
        public Object toMap() {
            return mapInstance;
        }
        public Object keySet() {
            return mapInstance.keySet().clone();
        }
    }

    private class MapByTime implements GenericMap {
        private Map<Time, Object> mapInstance;

        public MapByTime(Map<Time, Object> mapInstance) {
            this.mapInstance = mapInstance;
        }
        public void put(Object key, Object value) {
            mapInstance.put((Time) key, (List<SObject>) value);
        }
        public Boolean containsKey(Object key) {
            return mapInstance.containsKey((Time) key);
        }
        public Object get(Object key) {
            return mapInstance.get((Time) key);
        }
        public Object toMap() {
            return mapInstance;
        }
        public Object keySet() {
            return mapInstance.keySet().clone();
        }
    }
}