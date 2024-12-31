import json

def lambda_handler(event, context):
    # Load query string parameters
    resource = event.get("path", "").strip("/")
    
    if resource == "surah":
        with open("surah.json", "r") as file:
            surah_data = json.load(file)
        return {
            "statusCode": 200,
            "body": json.dumps(surah_data),
            "headers": {"Content-Type": "application/json"}
        }
    
    elif resource == "juz":
        with open("juz.json", "r") as file:
            juz_data = json.load(file)
        return {
            "statusCode": 200,
            "body": json.dumps(juz_data),
            "headers": {"Content-Type": "application/json"}
        }
    
    else:
        return {
            "statusCode": 404,
            "body": json.dumps({"message": "Resource not found"}),
            "headers": {"Content-Type": "application/json"}
        }
