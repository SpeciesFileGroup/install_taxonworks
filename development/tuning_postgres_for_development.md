PostgreSQL settings to get testing go faster
============================================

This instructions allows for faster testing. Them basically trade database integrity in case of failures for speed. **This shouldn't be done for production databases.**

You need to edit `/etc/postgresql/{your installed version here}/main/postgresql.conf`

Locate the following settings and change thier values to match the ones here
```
fsync = off                             # turns forced synchronization on or off
synchronous_commit = off                # synchronization level; on, off, or local
full_page_writes = off                  # recover from partial page writes
```

That's it. Tests should go faster.
