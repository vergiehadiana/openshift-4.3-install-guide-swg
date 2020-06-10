#!/bin/bash

function issueShutdownRHCOS() {
	ssh -i /root/oseinstall core@${HOST} sudo shutdown -h now
}

HOST=worker4 issueShutdownRHCOS
HOST=worker3 issueShutdownRHCOS
HOST=worker2 issueShutdownRHCOS
HOST=worker1 issueShutdownRHCOS
HOST=master3 issueShutdownRHCOS
HOST=master2 issueShutdownRHCOS
HOST=master1 issueShutdownRHCOS

