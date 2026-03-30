PAIR_TIME_SLOTS = {
    1: ("08:30", "10:00"),
    2: ("10:10", "11:40"),
    3: ("12:00", "13:30"),
    4: ("13:50", "15:20"),
    5: ("15:30", "17:00"),
    6: ("17:10", "18:40"),
}


def get_pair_time_range(pair_number):
    """Return formatted time range for pair number."""
    try:
        number = int(pair_number)
    except (TypeError, ValueError):
        return "-"

    slot = PAIR_TIME_SLOTS.get(number)
    if not slot:
        return "-"

    return f"{slot[0]} - {slot[1]}"
