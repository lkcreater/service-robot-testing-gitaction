# use python v3 only
FROM python:3

# Working directory folder
WORKDIR /usr/src/app

# Copy file dependencies requirement
COPY requirements.txt ./

# Copying source files
COPY . .

# Run install dependencies requirements
RUN pip install --no-cache-dir -r requirements.txt

# docker build -t automate_testing_tisco_ffd .
# docker run -it --rm --name docker_automate_test -v /:/my-project automate_testing_tisco_ffd
# bash -c "robot --outputdir ./resources/report  ./testcases/functional_tests"