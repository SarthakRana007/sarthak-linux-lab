# systemd: Wants=, Requires=, After=

## The one-line summary
Wants= and Requires= decide WHAT gets started.
After= decides in what ORDER.
That's why they're usually used together.

## Wants=  (optional dependency)
- Starting my unit also starts the units listed here.
- If one of them fails, my unit still starts.
- Use it for "nice to have": my service works better with it,
  but can run without it.

## Requires=  (mandatory dependency)
- Starting my unit also starts the units listed here.
- If a required unit is stopped, my unit is stopped too.
- On its own it starts both units AT THE SAME TIME, so my unit
  only reliably fails when the required one fails if After= is
  also set.

## After=  (order only)
- My unit waits until the listed units have FINISHED STARTING
  (not finished all their work).
- After= does NOT start the other unit. If nothing else starts
  it, After= does nothing.

## Typical combination
Requires=database.service
After=database.service
→ "Start the database, wait for it to be up, then start me.
   If the database fails, don't start me."

## Where to look
man systemd.unit  (type /Requires= to jump there)
