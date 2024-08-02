@IsTest
private class SetsTest {
    @IsTest
    static void isEmptyTest() {
        //Given
        Set<Id> nullSet = null;

        //Then
        System.assertEquals(true, Sets.isEmpty(nullSet), 'Set should be empty');

        //Then Set<Id>
        System.assertEquals(true, Sets.isEmpty(new Set<Id>()), 'Set should be empty');
        System.assertEquals(
            false,
            Sets.isEmpty(new Set<Id>{ TestUtils.getFakeId(Account.SObjectType) }),
            'Set should be empty'
        );

        //Then Set<String>
        System.assertEquals(true, Sets.isEmpty(new Set<String>()), 'Set should be empty');
        System.assertEquals(false, Sets.isEmpty(new Set<String>{ 'Test' }), 'Set should be empty');
    }

    @IsTest
    static void isNotEmptyTest() {
        //Given
        Set<Id> nullSet = null;

        //Then
        System.assertEquals(false, Sets.isNotEmpty(nullSet), 'Sets should be empty');

        //Then Set<Id>
        System.assertEquals(false, Sets.isNotEmpty(new Set<Id>()), 'Set should not be empty');
        System.assertEquals(
            true,
            Sets.isNotEmpty(new Set<Id>{ TestUtils.getFakeId(Account.SObjectType) }),
            'Set should not be empty'
        );
    }
}