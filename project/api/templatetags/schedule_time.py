from django import template

from api.time_utils import get_pair_time_range

register = template.Library()


@register.filter
def pair_time(value):
    return get_pair_time_range(value)
