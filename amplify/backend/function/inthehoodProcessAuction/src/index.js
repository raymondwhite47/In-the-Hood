const AWS = require("aws-sdk");

const dynamo = new AWS.DynamoDB.DocumentClient();
const { AUCTION_TABLE_NAME } = process.env;

exports.handler = async (event) => {
  console.log("updateAuction event", JSON.stringify(event));

  const input = event.arguments?.input ?? {};
  const { id, ...updates } = input;

  if (!id) {
    throw new Error("updateAuction requires an id.");
  }

  if (!AUCTION_TABLE_NAME) {
    console.warn("AUCTION_TABLE_NAME not set. Returning input without persistence.");
    return { id, ...updates };
  }

  const updateKeys = Object.keys(updates).filter((key) => updates[key] !== undefined);

  if (updateKeys.length === 0) {
    return { id };
  }

  const expressionNames = {};
  const expressionValues = {};
  const updateExpressions = updateKeys.map((key) => {
    const nameKey = `#${key}`;
    const valueKey = `:${key}`;
    expressionNames[nameKey] = key;
    expressionValues[valueKey] = updates[key];
    return `${nameKey} = ${valueKey}`;
  });

  const result = await dynamo
    .update({
      TableName: AUCTION_TABLE_NAME,
      Key: { id },
      UpdateExpression: `SET ${updateExpressions.join(", ")}`,
      ExpressionAttributeNames: expressionNames,
      ExpressionAttributeValues: expressionValues,
      ReturnValues: "ALL_NEW",
    })
    .promise();

  return result.Attributes ?? { id, ...updates };
};
