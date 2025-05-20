// app/index.js

const express = require('express');
const { AppConfigurationClient } = require('@azure/app-configuration');
const { DefaultAzureCredential } = require('@azure/identity');

// Initialize Express app
const app = express();
const port = process.env.PORT || 8080; // Azure requires PORT environment variable

// Ensure the Azure App Configuration endpoint is set
const appConfigEndpoint = process.env.AZURE_APPCONFIG_ENDPOINT;

if (!appConfigEndpoint) {
  console.error("❌ Error: AZURE_APPCONFIG_ENDPOINT is not set.");
  process.exit(1);
}

// Initialize Azure App Configuration Client
const client = new AppConfigurationClient(appConfigEndpoint, new DefaultAzureCredential());

app.get('/', async (req, res) => {
  try {
    const setting = await client.getConfigurationSetting({ key: 'saved_string' });

    if (setting && setting.value) {
      res.send(`<h1>The saved string is ${setting.value}</h1>`);
    } else {
      res.send(`<h1>Error: saved_string not found in App Configuration.</h1>`);
    }
  } catch (error) {
    console.error("❌ Error fetching configuration setting:");
    res.status(500).send(`<h1>Error: Unable to fetch the saved string.</h1>`);
  }
});

// Health Check Endpoint
app.get('/health', (req, res) => {
  res.status(200).send("Health Check: OK");
});

// Start the Express server
app.listen(port, () => {
  console.log(`✅ App listening on port ${port}`);
});
