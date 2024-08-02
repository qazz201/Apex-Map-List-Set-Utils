@IsTest
private class MapsTest {
    @IsTest
    static void testGroupByIdField() {
        //Given
        List<Account> accounts = getTestAccounts();
        insert accounts;

        //When
        Map<Id, List<Account>> groupedAccounts = (Map<Id, List<Account>>) Maps.groupBy(
            accounts,
            Account.Id
        );

        //Then
        System.assertEquals(5, groupedAccounts.size(), 'There should be 5 groups');
    }

    @IsTest
    static void testGroupByStringField() {
        //Given
        List<Account> accounts = getTestAccounts();

        //When
        Map<String, List<Account>> groupedAccounts = (Map<String, List<Account>>) Maps.groupBy(
            accounts,
            Account.Industry
        );

        //Then
        System.assertEquals(3, groupedAccounts.size(), 'There should be 3 groups');
        System.assertEquals(
            3,
            groupedAccounts.get('Technology').size(),
            'Technology should have 3 accounts'
        );
        System.assertEquals(
            1,
            groupedAccounts.get('Finance').size(),
            'Finance should have 1 account'
        );
        System.assertEquals(
            1,
            groupedAccounts.get('Manufacturing').size(),
            'Manufacturing should have 1 account'
        );
    }

    @IsTest
    static void testGroupByIntegerField() {
        //Given
        List<Account> accounts = getTestAccounts();

        //When
        Map<Integer, List<Account>> groupedAccounts = (Map<Integer, List<Account>>) Maps.groupBy(
            accounts,
            Account.NumberOfEmployees
        );

        //Then
        System.assertEquals(2, groupedAccounts.size(), 'There should be 3 groups');

        System.assertEquals(3, groupedAccounts.get(50).size(), 'Technology should have 3 accounts');
        System.assertEquals(2, groupedAccounts.get(150).size(), 'Finance should have 2 accounts');
    }

    @IsTest
    static void testGroupByDoubleField() {
        //Given
        List<Account> accounts = getTestAccounts();

        //When
        Map<Double, List<Account>> groupedAccounts = (Map<Double, List<Account>>) Maps.groupBy(
            accounts,
            Account.AnnualRevenue
        );

        //Then
        System.assertEquals(2, groupedAccounts.size(), 'There should be 3 groups');

        System.assertEquals(
            3,
            groupedAccounts.get(50.123).size(),
            'Technology should have 3 accounts'
        );
        System.assertEquals(
            2,
            groupedAccounts.get(150.123).size(),
            'Finance should have 2 accounts'
        );
    }

    @IsTest
    static void testGroupByDateTimeField() {
        //Given
        Account account1 = TestUtils.createAccount();
        Account account2 = TestUtils.createAccount();
        List<Account> accounts = new List<Account>{ account1, account2 };
        insert accounts;

        //When
        Map<Datetime, List<Account>> groupedAccounts = (Map<Datetime, List<Account>>) Maps.groupBy(
            accounts,
            Account.CreatedDate
        );

        //Then
        System.assertEquals(1, groupedAccounts.size(), 'There should be 1 group');
    }

    @IsTest
    static void testGroupByBooleanField() {
        //Given
        Account account1 = TestUtils.createAccount();
        Account account2 = TestUtils.createAccount();
        List<Account> accounts = new List<Account>{ account1, account2 };
        insert accounts;
        delete account1;

        //When
        Map<Boolean, List<Account>> groupedAccounts = (Map<Boolean, List<Account>>) Maps.groupBy(
            [SELECT Id, IsDeleted FROM Account ALL ROWS],
            Account.IsDeleted
        );

        //Then
        System.assertEquals(2, groupedAccounts.size(), 'There should be 2 groups');
    }

    @IsTest
    static void test() {
        //Given
        Account accObject = new Account(Name = 'Acme Inc.');

        Map<Id, Object> nullMap = null;
        Map<Id, Object> objectsByIds = new Map<Id, Object>();
        objectsByIds.put(TestUtils.getFakeId(Account.SObjectType), accObject);

        //Then
        System.assertEquals(true, Maps.isEmpty(nullMap), 'Map should be empty');

        //Then
        // Check Map<Id, Object>
        Assert.isTrue(Maps.isEmpty(new Map<Id, Object>()), 'Map should be empty');
        Assert.isTrue(Maps.isNotEmpty(objectsByIds), 'Map should not be empty');
        Assert.isFalse(Maps.isEmpty(objectsByIds), 'Map should be empty');

        //Check Map<String,Object>
        Assert.isTrue(Maps.isEmpty(new Map<String, Object>()), 'Map should be empty');
        Assert.isTrue(
            Maps.isNotEmpty(new Map<String, Object>{ 'Some String' => accObject }),
            'Map should not be empty'
        );
        Assert.isFalse(
            Maps.isEmpty(new Map<String, Object>{ 'Some String' => accObject }),
            'Map should be empty'
        );

        //Check Map<Double,Object>
        Assert.isTrue(Maps.isEmpty(new Map<Double, Object>()), 'Map should be empty');
        Assert.isTrue(
            Maps.isNotEmpty(new Map<Double, Object>{ 123.1 => accObject }),
            'Map should not be empty'
        );
        Assert.isFalse(
            Maps.isEmpty(new Map<Double, Object>{ 123.1 => accObject }),
            'Map should be empty'
        );
    }

    // Helper method to create test Account records
    private static List<Account> getTestAccounts() {
        List<Account> accounts = new List<Account>();

        accounts.add(
            new Account(
                Name = 'Acme Corp',
                Industry = 'Technology',
                AnnualRevenue = 50.123,
                BillingCity = 'San Francisco',
                NumberOfEmployees = 50
            )
        );
        accounts.add(
            new Account(
                Name = 'Globex',
                Industry = 'Finance',
                AnnualRevenue = 50.123,
                BillingCity = 'New York',
                NumberOfEmployees = 50
            )
        );
        accounts.add(
            new Account(
                Name = 'Initech',
                Industry = 'Technology',
                AnnualRevenue = 50.123,
                BillingCity = 'San Francisco',
                NumberOfEmployees = 50
            )
        );
        accounts.add(
            new Account(
                Name = 'Hooli',
                Industry = 'Technology',
                AnnualRevenue = 150.123,
                BillingCity = 'Palo Alto',
                NumberOfEmployees = 150
            )
        );
        accounts.add(
            new Account(
                Name = 'Vandelay Industries',
                Industry = 'Manufacturing',
                AnnualRevenue = 150.123,
                BillingCity = 'New York',
                NumberOfEmployees = 150
            )
        );

        return accounts;
    }
}