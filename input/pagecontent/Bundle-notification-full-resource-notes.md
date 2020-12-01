
In order to satisfy the requirements of a `history` Bundle (specifically `bdl-3` and `bdl-4`), note that `Bundle.entry.request` must exist.

For the status resource (`entry[0]`), the request is filled out to match a request to the `$status` operation.

For additional entries, the request SHOULD be filled out in a way that makes sense given the subscription (e.g., a `POST` or `PUT` operation on the resource).  However, a server MAY choose to simply include a `GET` to the relevant resource instead.
