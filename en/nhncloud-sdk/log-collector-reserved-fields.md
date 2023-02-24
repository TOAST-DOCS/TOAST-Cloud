## NHN Cloud > SDK User Guide > Log & Crash > Reserved Fields

### Definition of Reserved Fields

Reserved fields refer to field names which are defined and used within NHN Cloud SDK.
To use reserved fields in NHN Cloud SDK, 'reserved_" is added to a field name.
Inspection conditions of a reserved field regard to comparing character strings, regardless of the letter case.

### Usage Example of Reserved Fields

* When the letter case is same as in reserved fields

```
sendTime -> reserved_sendTime

```

* When the letter case is not same as in reserved fields

```
SENDTIME -> reserved_SENDTIME

```

### List of Reserved Fields

| Key | Description |
| --- | ----------- |
| projectName | Project name |
| projectVersion | Project version |
| logVersion | Log Sending API version  |
| logType | Log type |
| logSource | Log source |
| logLevel | Log level |
| body | Messages |
| sendTime | Log sending time |
| createTime | Log creation time |
| lncBulkIndex | Log sending order |
| transactionID | Original log number |
| DeviceModel | Device model |
| Carrier | Carrier information  |
| CountryCode | Country information |
| Platform | Platform information |
| NetworkType | Network type |
| DeviceID | Device identification number |
| SessionID | Session ID |
| launchedID | Original app installation number |
| UserID | User ID |
| SdkVersion | SDK version |
| CrashStyle | Crash occurrence language |
| SymMethod | Crash interpretation method |
| dmpData | Crash information |
| FreeMemory | Free memory |
| FreeDiskSpace | Free disk space |
| SinkVersion | Database saving module version |
| errorCode | Error code |
| crashMeta | Crash metadata |
| SymResult | Crash analysis result |
| ExceptionType | Crash type |
| Location | Crash occurrence location  |
| lncIssueID | Issue ID |
