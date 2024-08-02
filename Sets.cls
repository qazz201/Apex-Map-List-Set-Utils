public with sharing class Sets {
    /**
     * Check if incoming set of ids is null or empty
     */
    public static Boolean isEmpty(Set<Id> ids) {
        return ids == null || ids.isEmpty();
    }

    /**
     * Check if incoming set of values is null or empty
     */
    public static Boolean isEmpty(Set<String> values) {
        return values == null || values.isEmpty();
    }

    /**
     * Check if incoming set of ids is not null or empty
     */
    public static Boolean isNotEmpty(Set<Id> ids) {
        return !isEmpty(ids);
    }

    public static Boolean isNotEmpty(Set<String> values) {
        return !isEmpty(values);
    }
}