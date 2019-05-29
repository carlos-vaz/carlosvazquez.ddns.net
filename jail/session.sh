#!/bi/bash
# A simple read-eval-print loop
# You are placed here as user: webuser (UID = 1001)

sessionid=$1;
cd /home/webuser;

while true
do
        if read line </fifo/${sessionid}_tobash; then
                if [[ "$line" == 'quit' ]]; then
                        break
                fi
                ${line} &> /fifo/${sessionid}_tophp
        fi
done
echo "Finished" > /fifo/${sessionid}_tophp


