resource "aws_route53_record" "record" {
  for_each = {
    for record in var.records : join("-",
      [for i in [record.name, record.type, record.set_identifier] : i if i != null]
    ) => record
  }

  zone_id = coalesce(
    try(data.aws_route53_zone.zone[0].id, null),
    try(aws_route53_zone.zone[0].id, null)
  )

  name                             = each.value.name
  type                             = each.value.type
  ttl                              = each.value.ttl
  records                          = each.value.records
  set_identifier                   = each.value.set_identifier
  health_check_id                  = each.value.health_check_id
  multivalue_answer_routing_policy = each.value.multivalue_answer_routing_policy
  allow_overwrite                  = each.value.allow_overwrite

  dynamic "alias" {
    for_each = each.value.alias != null ? { for ali in [each.value.alias] : ali.name => ali } : {}

    content {
      name                   = alias.value.name
      zone_id                = alias.value.zone_id
      evaluate_target_health = alias.value.evaluate_target_health == null ? true : alias.value.evaluate_target_health
    }
  }

  dynamic "failover_routing_policy" {
    for_each = each.value.failover_routing_policy != null ? {
      for pol in [each.value.failover_routing_policy] : pol.type => pol
    } : {}

    content {
      type = failover_routing_policy.value.type
    }
  }

  dynamic "geolocation_routing_policy" {
    for_each = each.value.geolocation_routing_policy != null ? {
      for pol in [each.value.geolocation_routing_policy] : pol.continent => pol
    } : {}

    content {
      continent   = geolocation_routing_policy.value.continent
      country     = geolocation_routing_policy.value.country
      subdivision = geolocation_routing_policy.value.subdivision
    }
  }

  dynamic "latency_routing_policy" {
    for_each = each.value.latency_routing_policy != null ? {
      for pol in [each.value.latency_routing_policy] : pol.region => pol
    } : {}

    content {
      region = latency_routing_policy.value.region
    }
  }

  dynamic "weighted_routing_policy" {
    for_each = each.value.weighted_routing_policy != null ? {
      for pol in [each.value.weighted_routing_policy] : pol.weight => pol
    } : {}

    content {
      weight = weighted_routing_policy.value.weight
    }
  }
}
