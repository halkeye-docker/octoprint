build:
	docker build -t halkeye/octoprint .

run:
	docker run -it --rm -p 3000:5000 --name octoprint-build halkeye/octoprint

push:
	docker push halkeye/octoprint 
