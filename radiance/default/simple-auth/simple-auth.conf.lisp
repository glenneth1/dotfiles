; meta (:version 1.0 :package "SIMPLE-AUTH")
[hash-table equal
 (:recovery
  [hash-table eql (:timeout 86400) (:subject "Radiance Account Recovery")
   (:message
    "Hi, ~a.

An account recovery was recently requested. If this was you, please
use the following link to recover our account. If you did not request
a recovery, you can simply ignore this email.

    ~a

Note that the recovery link will expire after 24 hours and you will
not be sent a new mail before then.")])
 (:salt "0NcWW4A9bOdRmsjo") (:registration "open")]