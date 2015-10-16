PostgreSQL settings to speed up testing
=======================================

These setttings makes running the specs suite faster. They basically trade database integrity in case of failures for speed. **This shouldn't be done for production databases.**

Edit your `postgresql.conf` file, in Ubuntu it can be found here at `/etc/postgresql/{your installed version here}/main/postgresql.conf`.

Locate the following settings and change their values to match the ones here
```
fsync = off                             # turns forced synchronization on or off
synchronous_commit = off                # synchronization level; on, off, or local
full_page_writes = off                  # recover from partial page writes
```

That's it. Tests should go faster.
