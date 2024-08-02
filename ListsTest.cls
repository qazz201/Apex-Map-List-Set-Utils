@IsTest
private class ListsTest {
    @IsTest
    static void isEmptyTest() {
        //Given
        List<Object> nullList = null;
        List<Object> objects = new List<Object>();
        objects.add(new Account(Name = 'Acme Inc.'));

        //Then
        System.assertEquals(true, Lists.isEmpty(nullList), 'List should be empty');

        //Then List<Object>
        System.assertEquals(true, Lists.isEmpty(new List<Object>()), 'List should be empty');
        System.assertEquals(false, Lists.isEmpty(objects), 'List should not be empty');
    }

    @IsTest
    static void isNotEmptyTest() {
        //Given
        List<Object> nullList = null;
        List<Object> objects = new List<Object>();
        objects.add(new Account(Name = 'Acme Inc.'));

        //Then
        System.assertEquals(false, Lists.isNotEmpty(nullList), 'List should not be empty');

        //Then List<Object>
        System.assertEquals(
            false,
            Lists.isNotEmpty(new List<Object>()),
            'List should not be empty'
        );
        System.assertEquals(true, Lists.isNotEmpty(objects), 'List should be empty');
    }

    @IsTest
    static void testListStringFields() {
        //Given
        List<Account> records = new List<Account>{
            new Account(Name = 'Test Account'),
            new Account(Name = 'Test Account#2')
        };
        //When
        List<String> result = (List<String>) Lists.getFieldValues(records, Account.Name);
        List<String> result2 = (List<String>) Lists.getFieldValues(records, 'Name', String.class);

        //Then
        System.assertEquals(2, result.size(), 'Result should contain one element');
        System.assertEquals('Test Account', result[0], 'Result should match the account name');
        System.assertEquals('Test Account#2', result[1], 'Result should match the account name');

        //Case2
        System.assertEquals(2, result2.size(), 'Result should contain one element');
        System.assertEquals('Test Account', result2[0], 'Result should match the account name');
        System.assertEquals('Test Account#2', result2[1], 'Result should match the account name');
    }

    @IsTest
    static void testListIntegerFields() {
        //Given
        List<Account> records = new List<Account>{ new Account(NumberOfEmployees = 25) };
        //When
        List<Integer> result = (List<Integer>) Lists.getFieldValues(
            records,
            Account.NumberOfEmployees
        );
        List<Integer> result2 = (List<Integer>) Lists.getFieldValues(
            records,
            'NumberOfEmployees',
            Integer.class
        );

        //Then
        System.assertEquals(1, result.size(), 'Result should contain one element');
        System.assertEquals(25, result[0], 'Result should match the NumberOfEmployees value');

        //Case2
        System.assertEquals(1, result2.size(), 'Result should contain one element');
        System.assertEquals(25, result2[0], 'Result should match the NumberOfEmployees value');
    }

    @IsTest
    static void testListDecimalFields() {
        //Given
        List<Opportunity> records = new List<Opportunity>{ new Opportunity(Amount = 1000.50) };
        //When
        List<Decimal> result = (List<Decimal>) Lists.getFieldValues(records, Opportunity.Amount);
        List<Decimal> result2 = (List<Decimal>) Lists.getFieldValues(
            records,
            'Amount',
            Decimal.class
        );

        //Then
        System.assertEquals(1, result.size(), 'Result should contain one element');
        System.assertEquals(1000.50, result[0], 'Result should match the amount value');
        //Case2
        System.assertEquals(1, result2.size(), 'Result should contain one element');
        System.assertEquals(1000.50, result2[0], 'Result should match the amount value');
    }

    @IsTest
    static void testListBooleanFields() {
        //Given
        List<Lead> records = new List<Lead>{ new Lead(IsConverted = true) };
        //When
        List<Boolean> result = (List<Boolean>) Lists.getFieldValues(records, Lead.IsConverted);
        List<Boolean> result2 = (List<Boolean>) Lists.getFieldValues(
            records,
            'IsConverted',
            Boolean.class
        );

        //Then
        System.assertEquals(1, result.size(), 'Result should contain one element');
        System.assertEquals(true, result[0], 'Result should match the boolean value');

        //Case2
        System.assertEquals(1, result2.size(), 'Result should contain one element');
        System.assertEquals(true, result2[0], 'Result should match the boolean value');
    }

    @IsTest
    static void testListDateFields() {
        //Given
        List<Task> records = new List<Task>{ new Task(ActivityDate = Date.today()) };
        //When
        List<Date> result = (List<Date>) Lists.getFieldValues(records, Task.ActivityDate);
        List<Date> result2 = (List<Date>) Lists.getFieldValues(records, 'ActivityDate', Date.class);

        //Then
        System.assertEquals(1, result.size(), 'Result should contain one element');
        System.assertEquals(Date.today(), result[0], 'Result should match the date value');

        //Case2
        System.assertEquals(1, result2.size(), 'Result should contain one element');
        System.assertEquals(Date.today(), result2[0], 'Result should match the date value');
    }

    @IsTest
    static void testListDateTimeFields() {
        //Given
        List<Event> records = new List<Event>{ new Event(StartDateTime = Datetime.now()) };

        //When
        List<Datetime> result = (List<Datetime>) Lists.getFieldValues(records, Event.StartDateTime);
        List<Datetime> result2 = (List<Datetime>) Lists.getFieldValues(
            records,
            'StartDateTime',
            Datetime.class
        );

        //Then
        System.assertEquals(1, result.size(), 'Result should contain one element');
        System.assertEquals(
            Datetime.now().format(),
            result[0].format(),
            'Result should match the datetime value'
        );

        //Case2
        System.assertEquals(1, result2.size(), 'Result should contain one element');
        System.assertEquals(
            Datetime.now().format(),
            result2[0].format(),
            'Result should match the datetime value'
        );
    }

    @IsTest
    static void testListIdFields() {
        //Given
        List<Opportunity> records = new List<Opportunity>{
            new Opportunity(Id = TestUtils.getFakeId(Opportunity.SObjectType))
        };
        //When
        List<Id> result = (List<Id>) Lists.getFieldValues(records, Opportunity.Id);
        List<Id> result2 = (List<Id>) Lists.getFieldValues(records, 'Id', Id.class);

        //Then
        System.assertEquals(1, result.size(), 'Result should contain one element');
        System.assertNotEquals(null, result[0], 'Result should not be null');

        //Case2
        System.assertEquals(1, result2.size(), 'Result should contain one element');
        System.assertNotEquals(null, result2[0], 'Result should not be null');
    }

    @IsTest
    static void testListNULLFields() {
        //Given
        List<Opportunity> records = new List<Opportunity>{ new Opportunity() };
        //When
        List<Id> result = (List<Id>) Lists.getFieldValues(records, Opportunity.Id);
        List<Id> result2 = (List<Id>) Lists.getFieldValues(records, 'Id', Id.class);

        //Then
        System.assertEquals(0, result.size(), 'Result should contain one element');
        //Case2
        System.assertEquals(0, result2.size(), 'Result should contain one element');
    }
}