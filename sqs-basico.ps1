$endpoint = "http://localhost:4566"

# 1. Crear la cola
aws --endpoint-url $endpoint sqs create-queue --queue-name cola-practica

# 2. Obtener la URL de la cola
$queueUrl = aws --endpoint-url $endpoint sqs get-queue-url `
  --queue-name cola-practica --query QueueUrl --output text

# 3. Enviar un mensaje
aws --endpoint-url $endpoint sqs send-message `
  --queue-url $queueUrl --message-body "Hola desde la practica 3"

# 4. Recibir el mensaje
$resp = aws --endpoint-url $endpoint sqs receive-message `
  --queue-url $queueUrl | ConvertFrom-Json
$resp.Messages[0].Body

# 5. Borrar el mensaje usando su ReceiptHandle
aws --endpoint-url $endpoint sqs delete-message `
  --queue-url $queueUrl --receipt-handle $resp.Messages[0].ReceiptHandle

# 6. Verificar que la cola quedó vacía
aws --endpoint-url $endpoint sqs receive-message --queue-url $queueUrl