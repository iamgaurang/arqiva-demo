// app/index.js

const express = require('express');
const { AppConfigurationClient } = require('@azure/app-configuration');
const { DefaultAzureCredential } = require('@azure/identity');

const app = express();
const port = process.env.PORT || 3000;

const appConfigEndpoint = process.env.AZURE_APPCONFIG_ENDPOINT;

const client = new AppConfigurationClient(appConfigEndpoint, new DefaultAzureCredential());

app.get('/', async (req, res) => {
  try {
    const setting = await client.getConfigurationSetting({ key: 'saved_string' });
    res.send(`<h1>The saved string is ${setting.value}</h1>`);
  } catch (error) {
    res.send(`<h1>Error: Unable to fetch the saved string.</h1>`);
  }
});

app.listen(port, () => {
  console.log(`App listening on port ${port}`);
});