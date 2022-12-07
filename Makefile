TIMESTAMP:= $(shell python3 -c 'import time; print(int(time.time() * 1000))')
TOKEN:= $(shell AWS_PROFILE=davidg aws logs describe-log-streams --log-group-name TargetLogGroup --log-stream-name TargetStream --region=eu-west-2 | jq  '.logStreams[].uploadSequenceToken')

apply:
	terraform init
	cd lambda_function/ && \
	pip3 install --target ./package -r ./requirements.txt && \
	cd package && \
	zip -r ../lambda_function.zip . && \
	cd .. && \
	zip lambda_function.zip main.py
	AWS_PROFILE=davidg terraform apply -auto-approve

plan:
	terraform init
	zip -r lambda_function.zip lambda_function 
	AWS_PROFILE=davidg terraform plan

writelog:
	AWS_PROFILE=davidg aws logs put-log-events --log-group-name TargetLogGroup --log-stream-name TargetStream --log-events timestamp=${TIMESTAMP},message="hello ${TIMESTAMP}" --region=eu-west-2 --sequence-token=${TOKEN}

destroy:
	terraform init
	terraform destroy -auto-approve