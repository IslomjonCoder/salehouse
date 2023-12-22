/* -- List of API Constants used in the project -- */

// -- API URL --

const String baseUrl = 'https://salehousestrongbac.uz/api';
// https://salehousestrongbac.uz/api

// -- Base url --
const String baseUrlForImage = 'https://isfaanbac.uz';
// -- API Headers --
const Map<String, String> headers = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
};

// -- Token Key --
const String tokenKey = 'token';
const String loginKey = 'login';
const String passwordKey = 'password';

// -- API Endpoints --

// https://isfaanbac.uz/api/boss/data/debtors/{block}
const String debitorsEndpoint = '/boss/data/debitors';
// https://isfaanbac.uz/api/boss/data/news
const String newsEndpoint = '/boss/data/news';




// -------------------- Pagination --------------------
// https://isfaanbac.uz/api/boss/data/payments
const String paymentsEndpoint = '/boss/data/payments';
// https://isfaanbac.uz/api/boss/data/contracts
const String contractsEndpoint = '/boss/data/contracts';

// https://isfaanbac.uz/api/boss/data/homes/{block}
const String homesEndpoint = '/boss/data/homes';
// https://isfaanbac.uz/api/blocks/{object}
const String blockEndpoint = '/blocks';

// -------------------- Done --------------------
// https://isfaanbac.uz/api/login
const String loginEndpoint = '/login';
// https://isfaanbac.uz/api/boss/data/objects
const String objectsEndpoint = '/boss/data/objects';
// https://isfaanbac.uz/api/boss/data/regions
const String regionsEndpoint = '/boss/data/regions';
// https://isfaanbac.uz/api/boss/data/companies
const String companiesEndpoint = '/boss/data/companies';
// https://isfaanbac.uz/api/boss/data/freehomes/{block}
const String freeHomesEndpoint = '/boss/data/freehomes';
// https://isfaanbac.uz/api/boss/data/blocks
const String blocksEndpoint = '/boss/data/blocks';
// https://isfaanbac.uz/api/boss/data/payment
const String paymentEndpoint = '/boss/data/payment';