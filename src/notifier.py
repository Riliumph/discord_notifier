import json
import logging
import os
import urllib.request

import boto3

logger = logging.getLogger()
logger.setLevel(logging.INFO)

ssm = boto3.client("ssm")


def get_parameter(name: str) -> str:
    response = ssm.get_parameter(Name=name)

    return response["Parameter"]["Value"]


def post_message(message: str, webhook_url: str) -> None:
    payload = {"content": message, "allowed_mentions": {"parse": []}}

    request = urllib.request.Request(
        webhook_url,
        data=json.dumps(payload).encode("utf-8"),
        headers={
            "Content-Type": "application/json",
            "User-Agent": "notifier-lambda/1.0",
        },
        method="POST",
    )
    try:
        with urllib.request.urlopen(request, timeout=10) as response:
            logger.info("notification sent status=%s", response.status)
    except urllib.error.HTTPError as e:
        body = e.read().decode("utf-8")
        logger.error("status=%s body=%s", e.code, body)
        raise


def lambda_handler(event, context):
    logger.info("notification started")

    message = get_parameter(os.environ["MESSAGE_STORE_NAME"])

    webhook_url = get_parameter(os.environ["SENDING_STORE_NAME"])

    if not message.strip():
        logger.info("message is empty")
        return {"statusCode": 204}

    post_message(message=message, webhook_url=webhook_url)

    return {"statusCode": 200}
